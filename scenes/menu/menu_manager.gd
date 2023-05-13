extends Node
class_name MenuManager

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

# signal my_custom_signal

# ========
# class onready vars
# ========

@onready var main_menu: GameMainMenu = $%MainMenu
@onready var pause_menu: GamePauseMenu = $%PauseMenu

# ========
# class vars
# ========

# ========
# godot functions
# ========

func _ready():
	# connect main menu signals
	main_menu.play_button_pressed.connect(_on_main_menu_play_button_pressed)
	main_menu.quit_button_pressed.connect(_on_main_menu_quit_button_pressed)
	pause_menu.continue_button_pressed.connect(_on_pause_menu_continue_button_pressed)
	pause_menu.quit_to_menu_button_pressed.connect(_on_pause_menu_quit_to_menu_button_pressed)

	hide_menus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# ========
# signal handler
# ========


func _on_main_menu_play_button_pressed() -> void:
	"""called when the play button is pressed on the main menu"""

	# set the game state to playing
	_game_events.game_state_changed.emit(Types.GameState.PLAYING)


func _on_main_menu_quit_button_pressed() -> void:
	"""called when the quit button is pressed on the main menu"""

	_game_events.game_state_changed.emit(Types.GameState.QUIT)

func _on_pause_menu_continue_button_pressed() -> void:
	"""called when the continue button is pressed on the pause menu"""

	# set the game state to playing
	_game_events.game_state_changed.emit(Types.GameState.PLAYING)

func _on_pause_menu_quit_to_menu_button_pressed() -> void:
	"""called when the quit to menu button is pressed on the pause menu"""

	# set the game state to playing
	_game_events.game_state_changed.emit(Types.GameState.MAIN_MENU)

	

# ========
# class functions
# ========

func hide_menus() -> void:
	"""hide all game menus"""
	for child in get_children():
		child.visible = false

func show_main_menu() -> void:
	"""show the main menu"""

	if main_menu == null:
		print_debug("MenuManager: main menu is null")
		return

	main_menu.visible = true

func show_pause_menu() -> void:
	"""show the pause menu"""

	if pause_menu == null:
		print_debug("MenuManager: pause menu is null")
		return

	pause_menu.visible = true
