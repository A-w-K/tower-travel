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
	
	var ability_id: String = _msg.get("ability", null)
	if ability_id == null:
		print_debug("Ability not found")
		return
	
	parent.ability_manager.request_ability(ability_id)
	request_transition_to_last_state.emit()
