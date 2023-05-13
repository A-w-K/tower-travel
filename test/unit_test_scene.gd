extends Node2D
class_name UnitTestScene

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

@onready var state_machine: StateMachine = $%StateMachine
@onready var state_machine_empty: StateMachine = $%StateMachineEmpty

# @onready var my_label: Label = $%Label

# ========
# class vars
# ========

# ========
# godot functions
# ========


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# ========
# signal handler
# ========

func _on_custom_signal_event():
	pass

# ========
# class functions
# ========

