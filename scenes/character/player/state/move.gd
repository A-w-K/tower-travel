extends PlayerState

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

func update(delta: float) -> void:

	
	parent.movement_component.move(delta)

	if parent.movement_component.get_movement_vector() == Vector2.ZERO:
		request_transition_to_new_state.emit("Idle")

	handle_ability_input()
