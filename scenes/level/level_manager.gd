extends Node
class_name LevelManager

# ========
# singleton references
# ========

@onready var _helper = get_node("/root/HelperSingleton") as Helper
@onready var _game_events = get_node("/root/GameEventsSingleton") as GameEvents
@onready var _player_data = get_node("/root/PlayerDataSingleton") as PlayerData
@onready var _custom_resource_loader = get_node("/root/CustomResourceLoaderSingleton") as CustomResourceLoader

# ========
# export vars
# ========

@export var initial_level_to_load: Resource

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

# ========
# godot functions
# ========


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# ========
# signal handler
# ========

# ========
# class functions
# ========

func load_level() -> void:
	
	# TODO: implement proper level generation (needs more state in game states to ensure level is loaded before activated etc)

	if get_child_count() > 0:
		return 

	var level: Node = initial_level_to_load.instantiate()
	add_child(level)

func unload_level() -> void:
	
	if get_child_count() == 0:
		return 

	var level: Node = get_child(0)
	level.queue_free()
