extends AbilityController
class_name ShieldAbilityController

# ========
# export vars
# ========

@export var shield_duration: float = 3.0
@export var shield_count: int = 2
@export var shield_radius: Vector2 = Vector2(25,0)
@export var shield_speed: float = 3.0

# asumption is all entity sprites are 16px heigh
# so the initial offset is y-8 to center the shield rotation
var shield_offset: Vector2 = Vector2(0,-8)

# ========
# class signals
# ========

# ========
# class onready vars
# ========

# ========
# class vars
# ========

var active_shields_count: int = 0
var active_shields: Array[ShieldAbility]

# ========
# godot functions
# ========

# ========
# signal handler
# ========

func _on_shield_destroyed():
	"""
	a shield is destroyed
	"""

	if active_shields_count > 0:
		active_shields_count -= 1

	if active_shields_count == 0 and state != RECOVERING:
		start_recovery()

# ========
# class functions
# ========

func execute():
	"""
	execute shield ability
	"""
	
	print_debug("execute shield ability")

	spawn_shields()
	
	
func spawn_shields() -> void:
	"""
	spawn shields
	"""

	# ensure no further shields can be spawned
	state = ACTIVE

	# calculate the shield "interval" (360 degrees divided by the amount of shields to spawn)
	var shield_step: float = TAU / shield_count
	# spawn the shields in the foreground layer together with other projectiles etc
	var layer = _helper.get_foreground_layer()


	for i in range(shield_count):
		var shield_instance = ability_scene.instantiate() as ShieldAbility
		shield_instance.init(
			shield_radius.rotated(shield_step * i),
			shield_speed,
			shield_offset,
			shield_duration,
			ability_owner,
		)
		
		shield_instance.global_position = shield_offset + ability_owner.global_position
		shield_instance.shield_destroyed.connect(_on_shield_destroyed)
		active_shields_count += 1
		layer.add_child(shield_instance)
