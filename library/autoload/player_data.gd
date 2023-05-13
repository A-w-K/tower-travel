extends Node
class_name PlayerData
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

# @onready var my_label: Label = $%Label

# ========
# class vars
# ========

# availability ids available to player when a round starts
var selected_ability_ids: Array[String]= [
	"shield",
	"teleport",
]

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

func get_selected_abilities() -> Array[String]:
	"""returns the selected availabilties for this round"""
	return selected_ability_ids
