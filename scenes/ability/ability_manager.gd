extends Node
class_name AbilityManager

# ========
# singleton references
# ========

@onready var _helper = get_node("/root/HelperSingleton") as Helper
@onready var _game_events = get_node("/root/GameEventsSingleton") as GameEvents
@onready var _player_daya = get_node("/root/PlayerDataSingleton") as PlayerData
@onready var _custom_resource_loader = get_node("/root/CustomResourceLoaderSingleton") as CustomResourceLoader

# ========
# export vars
# ========

# ========
# class signals
# ========

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

func _ready() -> void:
	connect_ability_signals()

# ========
# signal handler
# ========

func _on_ability_activated(ability_id: String) -> void:
	ability_activated.emit(ability_id)

func _on_ability_recovery_started(ability_id: String, recovery_time: float) -> void:
	ability_recovery_started.emit(ability_id, recovery_time)

func _on_ability_recovery_complete(ability_id: String) -> void:
	ability_recovery_complete.emit(ability_id)

# ========
# class functions
# ========

func load_player_abilities() -> void:
	"""initializes the player abilities depending on the player data"""

	var abilities = _player_daya.get_selected_abilities()
	for aid in abilities:
		var ability_resource = _custom_resource_loader.get_ability_resource(aid)
		if ability_resource == null:
			continue

		var ability_controller_scene = ability_resource.ability_controller_scene.instantiate()
		add_child(ability_controller_scene)
		

func request_ability(ability_id: String) -> void:
	for controller in get_children():
		if controller is AbilityController and controller.ability_id == ability_id:
			controller.request_ability()
			break

func connect_ability_signals() -> void:
	"""connect all ability signals to manager"""
	for controller in get_children():
		if controller is AbilityController:
			controller.ability_activated.connect(_on_ability_activated)
			controller.ability_recovery_started.connect(_on_ability_recovery_started)
			controller.ability_recovery_complete.connect(_on_ability_recovery_complete)