# GdUnit generated TestSuite
class_name StateMachineTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://scenes/state/state_machine.gd'


func create_scene() -> UnitTestScene:
	"""instanciate the unit test scene for state_machine"""
	
	return auto_free(load("res://test/unit_test_scene.tscn").instantiate())

func test_sanity_check_unit_tests() -> void:
	"""ensure unit test scene is valid"""
	var scene: UnitTestScene = create_scene()
	var runner: GdUnitSceneRunner = scene_runner(scene)
	
	assert_object(scene.state_machine).is_not_null()
	assert_object(scene.state_machine_empty).is_not_null()


func test_initial_state_machine() -> void:
	"""test initial state of state machine"""
	
	var scene: UnitTestScene = create_scene()
	var runner: GdUnitSceneRunner = scene_runner(scene)
	
	assert_object(scene.state_machine.parent).is_not_null()
	assert_object(scene.state_machine.parent).is_instanceof(CharacterBody2D)
	assert_object(scene.state_machine.current_state).is_not_null()
	assert_object(scene.state_machine.current_state).is_instanceof(StateMachineState)
	assert_str(scene.state_machine.current_state.name as String).is_equal("StateA")

func test_initial_state_machine_empty() -> void:
	"""test the initial state of an empty state machine"""
	
	var scene: UnitTestScene = create_scene()
	var runner: GdUnitSceneRunner = scene_runner(scene)
	
	assert_object(scene.state_machine_empty.parent).is_not_null()
	assert_object(scene.state_machine_empty.parent).is_instanceof(CharacterBody2D)
	assert_object(scene.state_machine_empty.current_state).is_null()
