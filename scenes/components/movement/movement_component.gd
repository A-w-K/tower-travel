extends Node
class_name MovementComponent

# ========
# singleton references
# ========

@onready var _helper = get_node("/root/HelperSingleton") as Helper
@onready var _game_events = get_node("/root/GameEventsSingleton") as GameEvents

# ========
# export vars
# ========

@export var velocity_component: VelocityComponent

# ========
# class signals
# ========

# ========
# class onready vars
# ========

@onready var body: CharacterBody2D =_helper.get_parent_characterbody_2d(self)

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

