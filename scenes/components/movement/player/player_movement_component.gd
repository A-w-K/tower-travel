extends MovementComponent
class_name PlayerMovementComponent

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

func move(delta: float) -> void:
	"""
		moves the player
	"""

	var direction = get_movement_vector()
	velocity_component.accelerate_in_direction(direction, delta)
	velocity_component.move(body)

func get_movement_vector() -> Vector2:
	"""
		calculates the player movement vector 
		depending on their input
	"""

	var x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	var y = Input.get_action_strength("move_down") - Input.get_action_strength("move_up")

	return Vector2(x, y)
