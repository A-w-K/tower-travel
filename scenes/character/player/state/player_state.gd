extends StateMachineState
class_name PlayerState

# ========
# singleton references
# ========

# ========
# export vars
# ========

# ========
# class signals
# ========

# ========
# class onready vars
# ========

# ========
# class vars
# ========


# ========
# godot functions
# ========

# ========
# signal handler
# ========

# ========
# class functions
# ========

func init() -> void:
	parent = parent as Player

func handle_move_input() -> void:
	"""
	Handle player movement input
	"""

	if Input.is_action_just_pressed("move_down") or \
		Input.is_action_just_pressed("move_up") or \
		Input.is_action_just_pressed("move_left") or \
		Input.is_action_just_pressed("move_right"):

		request_transition_to_new_state.emit("Move")

func handle_ability_input() -> void:
	"""
	Handle player ability input
	"""

	if Input.is_action_just_pressed("shield"):
		request_transition_to_new_state.emit("Ability", { "ability": "shield" })

	if Input.is_action_just_pressed("teleport"):
		request_transition_to_new_state.emit("Ability", { "ability": "teleport" })
