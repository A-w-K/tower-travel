extends Node
class_name Helper

func get_foreground_layer() -> Node2D:
	"""
		returns the foreground layer node in the current scene
	"""

	var layer: Node2D = get_tree().get_first_node_in_group(Types.LayerGroups.foreground) as Node2D

	if layer:
		return layer

	return null

func get_player() -> Node2D:
	"""
	returns the player node 
	"""

	var player: Node2D = get_tree().get_first_node_in_group(Types.LayerGroups.player) as Node2D

	if player:
		return player

	return null

func get_parent_characterbody_2d(node: Node) -> CharacterBody2D:
	"""
	returns the first found characterbody2d node in the parent tree
	"""

	var parent = node.get_parent()

	if parent:
		if parent is CharacterBody2D:
			return parent

		return get_parent_characterbody_2d(parent)

	return null
