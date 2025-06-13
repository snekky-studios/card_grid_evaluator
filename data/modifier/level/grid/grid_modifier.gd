extends Resource
class_name GridModifier

const EMPTY_TILE_STRING : String = "**"

# a list of cards that will be fixed to the grid at the start of the level, indexed by tile
@export var cards : Dictionary[Vector2i, CardData] = {}

func _to_string() -> String:
	var output : String = ""
	for index_row : int in range(Globals.GRID_NUM_ROWS):
		for index_col : int in range(Globals.GRID_NUM_COLS):
			var card_data : CardData = cards[Vector2i(index_col, index_row)]
			if(card_data == null):
				output += EMPTY_TILE_STRING
			else:
				output += card_data._to_string()
			if(index_col < Globals.GRID_NUM_COLS - 1):
				output += " "
		if(index_row < Globals.GRID_NUM_ROWS - 1):
			output += "\n"
	return output
