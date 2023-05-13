# GdUnit generated TestSuite
class_name StateMachineStateTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://scenes/state/state_manager_state.gd'

var state: StateMachineState

func before_test() -> void:
	"""prepare test resources"""
	
	state = auto_free(StateMachineState.new())
	
func test_check_signal_existence() -> void:
	"""ensure all signals required for StateMachine exist"""
	
	assert_signal(state).is_signal_exists("request_transition_to_new_state")
	assert_signal(state).is_signal_exists("request_transition_to_last_state")
