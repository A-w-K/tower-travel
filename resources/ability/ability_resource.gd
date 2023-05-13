#
# TODO: Is it sensible to use a custom resource for abilities as they basically differ quite a bit?
# at the meoment the ability resources are not used (2023-05-09)
#

extends Resource
class_name AbilityResource

@export var id: String
@export var name: String
@export_multiline var description: String
@export var icon: Texture
@export var ability_controller_scene: PackedScene
