extends CharacterBody2D

# ========
# singleton references
# ========

@onready var _helper = get_node("/root/HelperSingleton") as Helper
@onready var _game_events = get_node("/root/GameEventsSingleton") as GameEvents

# ========
# export vars
# ========

# @export var my_export_var = 0

# ========
# class signals
# ========

# signal my_custom_signal

# ========
# class onready vars
# ========

@onready var hitbox_component: Area2D = $%HitboxComponent

# ========
# class vars
# ========

var max_speed: float = 75

# ========
# godot functions
# ========


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction = get_direction_to_player()
	velocity = direction * max_speed
	move_and_slide()


# ========
# signal handler
# ========

func _on_area_entered(area: Area2D):
	print('yarp')
	queue_free()

# ========
# class functions
# ========

func get_direction_to_player() -> Vector2:
	"""
	returns direction to player
	"""

	var player_node = _helper.get_player()
	
	if player_node == null:
		return Vector2.ZERO

	return (player_node.global_position - global_position).normalized()
