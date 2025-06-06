extends Objective
class_name ObjectiveFillTiles

@export var tiles_to_place : Array[Vector2i] = [] # list of all tiles that must be placed to satisfy the requirement
@export var tiles_placed : Array[Vector2i] = [] # list of relevant tiles that have had cards placed on them

func place_tile(tile : Vector2i) -> void:
	if(not tile in tiles_to_place):
		# tile is not part of requirement
		return
	if(tile in tiles_placed):
		# tile is already placed
		return
	tiles_placed.append(tile)
	updated.emit(self)
	return

func remove_tile(tile : Vector2i) -> void:
	if(not tile in tiles_to_place):
		# tile is not part of requirement
		return
	if(not tile in tiles_placed):
		# tile is not placed, so can't be removed
		return
	tiles_placed.erase(tile)
	updated.emit(self)
	return

func _to_string() -> String:
	var output : String = ""
	output += name + "\n"
	output += "Difficulty: " + DifficultyName[difficulty] + "\n"
	output += "Fill tiles at "
	for index_tile : int in range(tiles_to_place.size()):
		output += "(" + str(tiles_to_place[index_tile].x) + ", " + str(tiles_to_place[index_tile].y) + ")"
		if(index_tile < tiles_to_place.size() - 1):
			output += ", "
	output += "\nTiles already filled: "
	for index_tile : int in range(tiles_placed.size()):
		output += "(" + str(tiles_placed[index_tile].x) + ", " + str(tiles_placed[index_tile].y) + ")"
		if(index_tile < tiles_placed.size() - 1):
			output += ", "
	output += "\n"
	output += "Payout: $" + str(payout) + "\n"
	output += "Status: " + ("Complete" if is_complete else "Incomplete")
	return output
