extends Node2D

# ========
# singleton references
# ========

@onready var _helper = get_node("/root/HelperSingleton") as Helper
@onready var _game_events = get_node("/root/GameEventsSingleton") as GameEvents

@onready var hurtbox_test: PackedScene = preload("res://development/testing_scenes/hurtbox_test.tscn")

# ========
# export vars
# ========

# @export var my_export_var = 0

# ========
# class signals
# ========

# signal my_custom_signal

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


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _unhandled_input(event):

	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				var foreground_layer = _helper.get_foreground_layer()
				var hurtbox_instance = hurtbox_test.instantiate() as CharacterBody2D
				hurtbox_instance.global_position = get_global_mouse_position()
				foreground_layer.add_child(hurtbox_instance)

# ========
# signal handler
# ========

func _on_custom_signal_event():
	pass

# ========
# class functions
# ========
