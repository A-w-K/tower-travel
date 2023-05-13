extends Node
class_name GameEvents

# ========
# singleton references
# ========

@onready var _helper = get_node("/root/HelperSingleton") as Helper
@onready var _player_data = get_node("/root/PlayerDataSingleton") as PlayerData

# ========
# export vars
# ========

# @export var my_export_var = 0

# ========
# class signals
# ========

signal game_state_changed(game_state: Types.GameState)
signal ability_activated(ability_id: String)
signal ability_recovery_started(ability_id: String, recovery_time: float)
signal ability_recovery_complete(ability_id: String)

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

# ========
# signal handler
# ========

# TODO: define when to use game events singleton vs. signals between nodes in the same scene?
 
func _on_game_state_changed(game_state: Types.GameState) -> void:
	"""Called when the game state changes, proxies signal from gamestatemanager to other nodes"""

	print_debug("GameEvents", "_on_game_state_changed", "Game state changed: " + str(game_state))

	# TODO: send old gamestate or send transition name for specific actions,
	# also include additional meta info like seed for level generation?

	game_state_changed.emit(game_state)

func _on_ability_activated(ability_id: String) -> void:
	"""Called when an ability is requested"""

	print_debug("GameEvents", "_on_ability_activated", "Ability activated: " + ability_id)
	ability_activated.emit(ability_id)

func _on_ability_recovery_started(ability_id: String, recovery_time: float) -> void:
	"""Called when an ability started recovery process"""
	
	print_debug("GameEvents", "_on_ability_recovery_started", "Ability recovery started: " + ability_id + " - " + str(recovery_time))
	ability_recovery_started.emit(ability_id, recovery_time)

func _on_ability_recovery_complete(ability_id: String) -> void:
	"""Called when an ability completed recovery process"""
	
	print_debug("GameEvents", "_on_ability_recovery_complete", "Ability recovery complete: " + ability_id)
	ability_recovery_complete.emit(ability_id)

# ========
# class functions
# ========

