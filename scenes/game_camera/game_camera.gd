extends Camera2D


func _ready():
	make_current()


func _process(delta):
	global_position = global_position.lerp(return_player_position(), 1.0 - exp(-delta * 10))
	

func return_player_position() -> Vector2:
	"""
		assign target position if player exists
	"""

	var player_node: Node2D = get_tree().get_first_node_in_group("player") as Node2D
	if player_node:
		return player_node.global_position

	return Vector2.ZERO