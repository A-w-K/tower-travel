extends Node

# ========
# singleton references
# ========

@onready var _helper = get_node("/root/HelperSingleton") as Helper
@onready var _game_events = get_node("/root/GameEventsSingleton") as GameEvents
@onready var _player_data = get_node("/root/PlayerDataSingleton") as PlayerData

# ========
# export vars
# ========

@export var initial_game_state: Types.GameState = Types.GameState.MAIN_MENU

# ========
# class signals
# ========

# signal my_custom_signal

# ========
# class onready vars
# ========

# ========
# class vars
# ========

# ========
# godot functions
# ========


# Called when the node enters the scene tree for the first time.
func _ready():
	
	# when the main node enters ready state emit the game state changed signal
	_game_events.game_state_changed.emit(initial_game_state)

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

