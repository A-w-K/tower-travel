# GdUnit generated TestSuite
class_name PlayerDataTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://library/autoload/player_data.gd'

var player_data: PlayerData

func before_test() -> void:
	"""initialize resources for testing"""

	player_data = auto_free(PlayerData.new())

func test_get_selected_abilities() -> void:
	# remove this line and complete your test
	var selected_abilities: Array[String] = player_data.get_selected_abilities()

	assert_array(selected_abilities).contains_exactly(["shield", "teleport"])
