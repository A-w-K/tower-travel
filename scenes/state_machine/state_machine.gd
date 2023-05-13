# thanks to: https://www.gdquest.com/tutorial/godot/design-patterns/finite-state-machine/

extends Node
class_name StateMachine

# ========
# singleton references
# ========

@onready var _helper = get_node("/root/HelperSingleton") as Helper
@onready var _game_events = get_node("/root/GameEventsSingleton") as GameEvents

# ========
# export vars
# ========


# ========
# class signals
# ========

signal transitioned_to(state_name)

# ========
# class onready vars
# ========

# ========
# class vars
# ========

var parent: CharacterBody2D = null
# TODO: Is storing the last state really required?
var last_state: StateMachineState = null
var current_state: StateMachineState = null

# ========
# godot functions
# ========

# Called when the node enters the scene tree for the first time.
func _ready():
	await owner.ready
	parent = _helper.get_parent_characterbody_2d(self)
	set_initial_state()
	connect_state_signals()

func _unhandled_input(event: InputEvent) -> void:
	if current_state:
		current_state.handle_input(event)

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)


# ========
# signal handler
# ========

func _on_request_transition_to_new_state(state_name: String, msg: Dictionary = {}) -> void:
	transition_to(state_name, msg)

func _on_request_transition_to_last_state(msg: Dictionary = {}) -> void:
	transition_to(last_state.name, msg)

# ========
# class functions
# ========

func set_initial_state() -> void:
	"""set the initial state of the state machine"""
	
	if current_state == null:
		for i in range(get_child_count()):
			var child = get_child(i)
			if child is StateMachineState:
				current_state = child
				break

func connect_state_signals() -> void:
	"""connect the state signals to the state machine"""
	
	for child in get_children():
		if child is StateMachineState:
			child.parent = parent
			child.request_transition_to_new_state.connect(_on_request_transition_to_new_state)
			child.request_transition_to_last_state.connect(_on_request_transition_to_last_state)


func transition_to(target_state_name: String, msg: Dictionary = {}) -> void:
	"""transition between states """
	if not has_node(target_state_name):
		return

	current_state.exit()
	last_state = current_state
	current_state = get_node(target_state_name)
	current_state.enter(msg)
	transitioned_to.emit(current_state.name)
