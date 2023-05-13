extends AbilityController
class_name TeleportAbilityController

# ========
# singleton references
# ========


# ========
# export vars
# ========

@export var teleport_distance: float = 50.0

# ========
# class signals
# ========


# ========
# class onready vars
# ========


# ========
# class vars
# ========

# ========
# godot functions
# ========

# ========
# signal handler
# ========

# ========
# class functions
# ========

func execute():
	"""
	run teleport ability
	"""

	teleport()


func teleport() -> void:
	"""
	teleport the owner of the ability
	"""	

	#TODO: add collission detection for non teleportable thingys
	#TODO: ensure entity is invisible during teleportation
	state = ACTIVE

	ability_owner.global_position += ability_owner.velocity.normalized() * teleport_distance

	start_recovery()


