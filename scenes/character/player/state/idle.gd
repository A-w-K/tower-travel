extends PlayerState

# ========
# singleton references
# ========

# ========
# export vars
# ========

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

func enter(_msg := {}) -> void:
	# TODO: switch to VelocityComponent! for manipulation instead!
	parent.velocity = Vector2.ZERO


func update(delta: float) -> void:
	handle_move_input()
	handle_ability_input()	
