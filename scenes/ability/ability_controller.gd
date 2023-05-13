extends Node
class_name AbilityController


# ========
# singleton references
# ========

@onready var _helper = get_node("/root/HelperSingleton") as Helper
@onready var _game_events = get_node("/root/GameEventsSingleton") as GameEvents

# ========
# export vars
# ========

@export var ability_scene: PackedScene
@export var ability_id: String
@export var ability_name: String
@export var recovery_time: float = 5.0

# ========
# class signals
# ========

signal ability_activated(ability_id: String)
signal ability_recovery_started(ability_id: String, recovery_time: float)
signal ability_recovery_complete(ability_id: String)

# ========
# class onready vars
# ========

@onready var ability_owner: CharacterBody2D = _helper.get_parent_characterbody_2d(self)
@onready var recovery_timer: Timer = Timer.new()

# ========
# class vars
# ========

# any player ability is either available (ready to use)
# recovering after use or active (currently in use)
enum {
	AVAILABLE,
	RECOVERING,
	ACTIVE
}

var state: int = AVAILABLE

# ========
# godot functions
# ========

func _ready():
	add_child(recovery_timer)
	recovery_timer.timeout.connect(_on_recovery_timer_timeout)

# ========
# signal handler
# ========

func _on_recovery_timer_timeout() -> void:
	"""
		sets the state to available and emits the signal
	"""

	print_debug("AbilityController: recovery timer timeout")
	state = AVAILABLE
	ability_recovery_complete.emit(ability_id)

# ========
# class functions
# ========

func request_ability() -> void:
	"""
		returns true if the ability is available
	"""

	print_debug("AbilityController: request availability")

	if state != AVAILABLE:
		return

	ability_activated.emit(ability_id)
	execute()

func start_recovery() -> void:
	"""
		sets the state to recovering and starts the recovery timer
	"""

	print_debug("AbilityController: start recovery")

	state = RECOVERING
	ability_recovery_started.emit(ability_id, recovery_time)
	recovery_timer.start(recovery_time)


func execute() -> void:
	"""
		executes the ability
		needs to be implemented by specific ability controller
	"""
	pass
