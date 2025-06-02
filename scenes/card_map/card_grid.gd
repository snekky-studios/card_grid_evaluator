extends Node2D
class_name CardGrid

signal card_grid_changed
signal card_grid_full

const TILE_ERROR : Vector2i = Vector2i(-1, -1)

var size : Vector2i = Vector2i.ZERO : set = _set_size
var cards : Dictionary = {} # a list of all the cards in the grid, indexed by coordinate

func _ready() -> void:
	return

# adds a cards to the `cards` dictionary, indexed by vector location
func add_card(tile : Vector2i, card : Node) -> void:
	cards[tile] = card
	card_grid_changed.emit()
	return

# removes card from the `cards` dictionary
func remove_card(tile : Vector2i) -> void:
	var card : Node = cards[tile]
	if not card:
		return
	cards[tile] = null
	card_grid_changed.emit()
	return

# locks all cards in the grid
func lock_cards() -> void:
	for tile : Vector2i in cards:
		var card : Card = cards[tile]
		if(card != null and not card.data.is_fixed):
			card.data.is_locked = true
	return

# unlocks all cards in the grid
func unlock_cards() -> void:
	for tile : Vector2i in cards:
		var card : Card = cards[tile]
		if(card != null):
			card.data.is_locked = false
	return

# adds the card data from all cards in the given row to an array and returns it
func get_row_of_cards(row : int) -> Array[CardData]:
	var card_data_array : Array[CardData] = []
	for index_col : int in range(size.x):
		if(cards[Vector2i(index_col, row)] != null):
			card_data_array.append(cards[Vector2i(index_col, row)].data)
	return card_data_array

# adds the card data from all cards in the given column to an array and returns it
func get_column_of_cards(col : int) -> Array[CardData]:
	var card_data_array : Array[CardData] = []
	for index_row : int in range(size.y):
		if(cards[Vector2i(col, index_row)] != null):
			card_data_array.append(cards[Vector2i(col, index_row)].data)
	return card_data_array

# returns true if any card in row is unlocked and unfixed, false otherwise
func row_contains_new_cards(row : int) -> bool:
	for index_col : int in range(size.x):
		if(cards[Vector2i(index_col, row)] and not cards[Vector2i(index_col, row)].data.is_locked and not cards[Vector2i(index_col, row)].data.is_fixed):
			return true
	return false

# returns true if any card in row is unlocked and unfixed, false otherwise
func col_contains_new_cards(col : int) -> bool:
	for index_row : int in range(size.y):
		if(cards[Vector2i(col, index_row)] and not cards[Vector2i(col, index_row)].data.is_locked and not cards[Vector2i(col, index_row)].data.is_fixed):
			return true
	return false

# returns true if the `tile` has a card associated with it, false otherwise
func is_tile_occupied(tile : Vector2i) -> bool:
	return cards[tile] != null

# returns true if every tile is occupied
func is_grid_full() -> bool:
	# calls is_tile_occupied on every value in the dictionary and ands the results
	return cards.keys().all(is_tile_occupied)

# returns the first tile that has not card associated with it
func get_first_empty_tile() -> Vector2i:
	for tile : Vector2i in cards:
		if not is_tile_occupied(tile):
			return tile
	# no empty tiles, return error value
	card_grid_full.emit()
	return TILE_ERROR

# adds all cards in the dictionary to an array and returns it
func get_all_cards() -> Array[Card]:
	var card_array : Array[Card] = []
	var card_values : Array[Card] = []
	for index_cards : int in cards.keys():
		if(cards[index_cards] != null):
			card_values.append(cards[index_cards])
	for card : Card in card_values:
		if card:
			card_array.append(card)
	return card_array

# adds all tiles with an associated card to an array and returns it
func get_all_occupied_tiles() -> Array[Vector2i]:
	var tile_array : Array[Vector2i] = []
	for tile : Vector2i in cards:
		if(is_tile_occupied(tile)):
			tile_array.append(tile)
	return tile_array

func _set_size(value : Vector2i) -> void:
	size = value
	# initialize cards dictionary with null values
	for index_x : int in size.x:
		for index_y : int in size.y:
			cards[Vector2i(index_x, index_y)] = null
	return
