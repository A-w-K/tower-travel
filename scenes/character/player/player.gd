extends CharacterBody2D
class_name Player

@onready var _helper = get_node("/root/HelperSingleton") as Helper
@onready var _game_events = get_node("/root/GameEventsSingleton") as GameEvents

@onready var ability_manager: AbilityManager = $AbilityManager
@onready var health_component: HealthComponent = $HealthComponent
@onready var velocity_component: VelocityComponent = $VelocityComponent
@onready var movement_component: MovementComponent = $PlayerMovementComponent
@onready var hurtbox_component: HurtboxComponent = $HurtboxComponent

func _ready():
	"""initialize player state"""

	load_player_abilities()
	register_abilities_at_game_events()

func register_abilities_at_game_events() -> void:
	"""register abilities at game events"""

	for ability in ability_manager.get_children():
		if ability is AbilityController:
			ability.ability_activated.connect(_game_events._on_ability_activated)
			ability.ability_recovery_started.connect(_game_events._on_ability_recovery_started)
			ability.ability_recovery_complete.connect(_game_events._on_ability_recovery_complete)

func load_player_abilities() -> void:
	"""load player abilities into ability manager"""

	# the player characters ability manager needs to dynamically
	# load the abilities from the player data (as it may change depending on players choices)
	ability_manager.load_player_abilities()
	ability_manager.connect_ability_signals()


func _process(delta):
	pass
