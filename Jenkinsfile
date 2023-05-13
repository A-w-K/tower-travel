//
// test and build pipeline for tower-travel
//


// python script to create github release
github_release_py='''
import requests
import json
import os
import pathlib

# GitHub repository details
owner = 'sebastianhutter'
repo = 'godot4-demo'

# GitHub access token with "repo" scope
access_token = os.getenv('PAT')
releases_url =  f'https://api.github.com/repos/{owner}/{repo}/releases'
headers = dict(
    Authorization=f'Bearer {access_token}'
)

# Release details
tag_name = os.getenv('TAG_NAME')
release_name = tag_name

# create the release
payload=dict(
    tag_name=tag_name,
    name=release_name,
    generate_release_notes=True,
)
response = requests.post(url=releases_url, headers=headers, json=payload)

assets_url = f'https://uploads.github.com/repos/{owner}/{repo}/releases/{response.json()["id"]}/assets'
for item in pathlib.Path('build').glob('**/*'):
    if item.is_file():
        with open(item, "rb") as f:
            response = requests.post(url=f'{assets_url}?name={item.name}', headers={**headers, **{'Content-Type': 'application/octet-stream'}}, data=f.read()) 
            if response.status_code == 201:
                print("File uploaded successfully!")
            else:
                print(f"Failed to upload file: {response.text}")
'''

pipeline {
    options { 
      disableConcurrentBuilds() 
      buildDiscarder logRotator(artifactDaysToKeepStr: '10', artifactNumToKeepStr: '10', daysToKeepStr: '', numToKeepStr: '')
    }
    parameters {
        booleanParam(
            defaultValue: true,
            description: 'Run tests',
            name: 'RUN_TESTS',
        )
        booleanParam(
            defaultValue: false,
            description: 'Build and export for windows and linux even when not master or tag release?',
            name: 'BUILD'
        )
    }
    agent {
        kubernetes {
            yaml """
apiVersion: v1
kind: Pod
spec:
  securityContext:
    runAsUser: 1000
    runAsGroup: 1000
  containers:
  - name: build-container
    image: sebastianhutter/godot-runner:main
    imagePullPolicy: Always
    command:
    - cat
    tty: true
    volumeMounts:
    - mountPath: /dev/snd
      name: dev-snd
    securityContext:
      # required for /dev/snd device access
      privileged: true
    resources:
      limits:
        # https://kubernetes.io/docs/tasks/manage-gpus/scheduling-gpus/
        # reserve nvidia graphics card in host
        nvidia.com/gpu: 1
  - name: github
    image: python:3.11-slim
    command:
    - cat
    tty: true
    securityContext:
      runAsUser: 0
      allowPrivilegeEscalation: true
  volumes:
  - name: dev-snd
    hostPath:
      path: /dev/snd
"""
        }
    }
    stages {
        stage('Prepare container') {
            steps {
                container('build-container') {
                    sh( 
                        script: """
                            sudo Xvfb -ac \${DISPLAY} -screen 0 1280x1024x24 > /dev/null &
                        """
                    )
                }
            }
        }
        stage('Test') {
            when {
                expression { return params.RUN_TESTS }
            }
            steps {
                container('build-container') {
                    sh(
                        script: '''
                            $GODOT_BIN --export-release "ci-setup" /tmp/gdunit4
                            rm -rf /tmp/gdunit4
                        '''
                    )
                    sh(
                        script: '''
                        if [ -d "./test" ]; then
                            bash addons/gdUnit4/runtest.sh -a ./test
                        fi
                        '''
                    )
                }
            }
            post {
                always {
                    container('build-container') {
                        junit(
                            testResults: '**/reports/report_1/**/results.xml',
                            allowEmptyResults: true,
                        )
                    }
                }
            }
        }
        stage('Build on Platforms') {
            when {
                anyOf {
                    tag "*"
                    branch "main"
                    expression { return params.BUILD }
                }
            }
            matrix {
                axes {
                    axis {
                        name "PLATFORM"
                        values "linux", "windows"
                    }
                }
                stages {
                    stage('Build') {
                        steps {
                            container('build-container') {
                                lock( 'synchronous-matrix' ) {
                                    script {
                                        def fileName = null
                                        switch(env.PLATFORM) {
                                            case "linux":
                                                fileName = "tower-travel.x86_64.bin";
                                                break;
                                            case "windows":
                                                fileName = "tower-travel.exe";
                                                break;
                                            default:
                                                throw new Exception ("Unknown platform")
                                        }
                                        sh(
                                            script: """
                                                mkdir -p build/\${PLATFORM}
                                                \$GODOT_BIN --export-release "\${PLATFORM}" build/\${PLATFORM}/${fileName}
                                            """
                                        )
                                    }
                                }
                            }
                        }
                    }
                }
            }
            post {
                success {
                    archiveArtifacts(
                        artifacts: "build/**/*",
                        fingerprint: true
                    )
                }
            }
        }
        stage('Release') {
            when {
                tag "*"
            }
            environment {
                GITHUB_PAT = credentials('github-machine-user-pat')
                PAT = "${GITHUB_PAT_PSW}"
            }
            steps {
                container('github') {
                    writeFile(
                        file: 'release.py',
                        text: github_release_py,
                        encoding: 'UTF-8'
                    )
                    sh(
                        script: '''
                            pip install --upgrade pip
                            pip install requests 
                            python release.py
                        '''
                    )
                }
            }
        }
    }
}
