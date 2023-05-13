extends CanvasLayer
class_name GameMainMenu

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

# @export var my_export_var = 0

# ========
# class signals
# ========

signal play_button_pressed
signal quit_button_pressed

# ========
# class onready vars
# ========

@onready var play_button: Button = $%PlayButton
@onready var quit_button: Button = $%QuitButton

# ========
# class vars
# ========

# ========
# godot functions
# ========


# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.pressed.connect(_on_play_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# ========
# signal handler
# ========

func _on_play_button_pressed() -> void:
	"""emit the play pressed signal"""
	play_button_pressed.emit()

func _on_quit_button_pressed() -> void:
	"""emit the quit pressed signal"""
	quit_button_pressed.emit()

# ========
# class functions
# ========

