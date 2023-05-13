extends Node
class_name VelocityComponent

# ========
# singleton references
# ========

@onready var _helper = get_node("/root/HelperSingleton") as Helper
@onready var _game_events = get_node("/root/GameEventsSingleton") as GameEvents

# ========
# export vars
# ========

@export var max_speed: float = 100.0

# ========
# class signals
# ========

# ========
# class onready vars
# ========

# ========
# class vars
# ========

var velocity: Vector2 = Vector2.ZERO

# ========
# godot functions
# ========

# ========
# signal handler
# ========

# ========
# class functions
# ========

# func calculate_friction() -> float:
# 	"""
# 	calculates friction based on accelation and speed
# 	"""
	
# 	return (acceleration / max_speed) * friction_modifier

func accelerate_in_direction(direction: Vector2, delta: float) -> void:
	# TODO: fix proper movement

	velocity = direction * max_speed #* delta

# func decelerate() -> void:
# 	"""
	
# 	"""

# 	if enable_friction:
# 		velocity -= velocity * calculate_friction() * delta

func move(body: CharacterBody2D) -> void:
	"""
	moves the body
	"""

	body.velocity = velocity
	body.move_and_slide()
