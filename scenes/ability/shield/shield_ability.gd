extends Node2D
class_name ShieldAbility

# ========
# singleton references
# ========

@onready var _helper = get_node("/root/HelperSingleton") as Helper
@onready var _game_events = get_node("/root/GameEventsSingleton") as GameEvents

# ========
# export vars
# ========

@export var recovery_time: float = 5.0
@export var duration_time: float = 3.0
@export var shield_count: int = 2
@export var shield_radius: Vector2 = Vector2(25,0)
@export var shield_speed: float = 3.0

# ========
# class signals
# ========

signal shield_destroyed

# ========
# class onready vars
# ========

@onready var timer: Timer = $%Timer
@onready var pivot: Node2D = $%Pivot
@onready var shield: Node2D = $%Shield
@onready var animation_player: AnimationPlayer = $%AnimationPlayer
@onready var health_component: HealthComponent = $%HealthComponent

# ========
# class vars
# ========

var radius: Vector2
var speed: float
var offset: Vector2
var rotation_target: Node2D
var duration: float
# asumption is all entity sprites are 16px heigh
# so the initial offset is y-8 to center the shield rotation
@export var shield_offset: Vector2 = Vector2(0,-8)

# ========
# godot functions
# ========

func _ready():
	shield.position = radius
	timer.wait_time = duration

	health_component.died.connect(destroy_shield)

	timer.timeout.connect(_on_timer_timeout)
	timer.start()

func _process(delta: float) -> void:
	"""
		rotate the shield around the given rotation target
	"""

	if not rotation_target:
		push_warning("No rotation target defined for shield")
		return

	position = rotation_target.global_position + offset
	pivot.rotation += speed * delta


# ========
# signal handler
# ========

func _on_timer_timeout() -> void:
	animation_player.play("destroy")

# ========
# class functions
# =======

func init(radius: Vector2, speed: float, offset: Vector2, duration: float, rotation_target: Node2D):
	"""
	initialize values, alternative to use custom constructor... kinda funky with packed scenes
	"""

	self.radius = radius
	self.speed = speed
	self.offset = offset
	self.duration = duration
	self.rotation_target = rotation_target

func destroy_shield() -> void:
	"""
	destroy the shield
	"""

	print_debug("Shield destroyed")
	shield_destroyed.emit()
	call_deferred("queue_free")
