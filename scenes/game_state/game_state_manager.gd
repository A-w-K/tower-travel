extends Node
class_name GameStateManager

# ========
# singleton references
# ========

@onready var _helper = get_node("/root/HelperSingleton") as Helper
@onready var _game_events = get_node("/root/GameEventsSingleton") as GameEvents
@onready var _player_data = get_node("/root/PlayerDataSingleton") as PlayerData

# ========
# export vars
# ========

@export var ui_manager: UiManager
@export var menu_manager: MenuManager
@export var level_manager: LevelManager

# ========
# class signals
# ========

# ========
# class onready vars
# ========

# @onready var my_label: Label = $%Label

# ========
# class vars
# ========

var current_state: Types.GameState

# ========
# godot functions
# ========

# Called when the node enters the scene tree for the first time.
func _ready():
	_game_events.game_state_changed.connect(_on_game_state_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):
	"""
	Handles input events that are handled by any other node
	"""

	if event is InputEventKey:
		# handle escape key presses
		if event.pressed and event.keycode == KEY_ESCAPE:
			if current_state == Types.GameState.PLAYING:
				_game_events.game_state_changed.emit(Types.GameState.PAUSED)
			elif current_state == Types.GameState.PAUSED:
				_game_events.game_state_changed.emit(Types.GameState.PLAYING)
			elif current_state == Types.GameState.MAIN_MENU:
				_game_events.game_state_changed.emit(Types.GameState.QUIT)


# ========
# signal handler
# ========

func _on_game_state_changed(game_state: Types.GameState) -> void:

	print_debug("GameStateManager: game state changed to " + str(game_state))
	
	current_state = game_state

	match game_state:
		Types.GameState.MAIN_MENU:
			menu_manager.hide_menus()
			ui_manager.hide_ui()
			level_manager.unload_level()
			menu_manager.show_main_menu()
			get_tree().paused = true
		Types.GameState.PLAYING:
			menu_manager.hide_menus()
			ui_manager.load_ability_cards()
			ui_manager.show_ui()
			level_manager.load_level()
			get_tree().paused = false
		Types.GameState.PAUSED:
			ui_manager.hide_ui()
			menu_manager.hide_menus()
			menu_manager.show_pause_menu()
			get_tree().paused = true
		Types.GameState.QUIT:
			get_tree().quit()

	

# ========
# class functions
# ========

