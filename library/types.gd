class_name Types

# possible game states for game state manager
enum GameState {
	MAIN_MENU,
	PLAYING,
	PAUSED,
	ROUND_WON,
	GAME_OVER,
	QUIT,
}

# map group names to layer names
const LayerGroups = {
	"foreground": "layer_foreground",
	"entity": "layer_entity",
	'player': 'player',
}
