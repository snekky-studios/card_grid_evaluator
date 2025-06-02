extends Node
class_name CardMover

const CARD_MAP_ERROR : int = -1

var card_maps : Array[CardMap]

func _ready() -> void:
	var cards : Array[Node] = get_tree().get_nodes_in_group("cards")
	for card : Card in cards:
		setup_card(card)
	return

func setup_card(card : Card) -> void:
	card.drag_and_drop.drag_started.connect(_on_card_drag_started.bind(card))
	card.drag_and_drop.drag_canceled.connect(_on_card_drag_canceled.bind(card))
	card.drag_and_drop.dropped.connect(_on_card_dropped.bind(card))
	return

func _set_highlighters(enabled : bool) -> void:
	for card_map : CardMap in card_maps:
		card_map.tile_highlighter.enabled = enabled
	return

# return the index of the play area in which the coordinate is located, or CARD_MAP_ERROR if not in any play areas
func _get_card_map_for_position(global : Vector2) -> int:
	for index_card_map : int in card_maps.size():
		var tile : Vector2i = card_maps[index_card_map].get_tile_from_global(global)
		if(card_maps[index_card_map].is_tile_in_bounds(tile)):
			return index_card_map
	return CARD_MAP_ERROR

# calculates which tile in which card_map to add the card back into, and adds it back to that tile and play area
func _reset_card_to_starting_position(starting_position : Vector2, card : Card) -> void:
	# get the tile/play area to add card back to
	var index_card_map : int = _get_card_map_for_position(starting_position)
	var tile : Vector2i = card_maps[index_card_map].get_tile_from_global(starting_position)
	# send the card back to the starting tile and add it back to the play area
	card.reset_after_dragging(starting_position)
	card_maps[index_card_map].card_grid.add_card(tile, card)
	return

# moves the card to a specified tile in a specified card_map
func _move_card(card : Card, card_map : CardMap, tile : Vector2i) -> void:
	# add card to card_grid dictionary
	card_map.card_grid.add_card(tile, card)
	# move card to new tile, with offset to account for tile center
	card.global_position = card_map.get_global_from_tile(tile) - Globals.CELL_SIZE_HALF
	# change child ownership of card to new card_grid
	card.reparent(card_map.card_grid)
	return

func _on_card_drag_started(card : Card) -> void:
	# we want highlighters enabled while we are dragging a card around
	_set_highlighters(true)
	# determine which play area the card starts in
	var index_card_map : int = _get_card_map_for_position(card.global_position)
	if(index_card_map != CARD_MAP_ERROR):
		# we are dragging the card out of this play area, so remove it
		var tile : Vector2i = card_maps[index_card_map].get_tile_from_global(card.global_position)
		card_maps[index_card_map].card_grid.remove_card(tile)
	return

func _on_card_drag_canceled(starting_position : Vector2, card : Card) -> void:
	# turn off highlighters, we are no longer dragging a card
	_set_highlighters(false)
	_reset_card_to_starting_position(starting_position, card)
	return

func _on_card_dropped(starting_position : Vector2, card : Card) -> void:
	# turn off highlighters, we are no longer dragging a card
	_set_highlighters(false)
	# keep track of both the starting and ending card_maps, in case we need to swap cards
	var index_card_map_start : int = _get_card_map_for_position(starting_position)
	var index_card_map_dropped : int = _get_card_map_for_position(card.get_global_mouse_position())
	# the card was dropped out of bounds of any play areas, so send it back to starting position
	if(index_card_map_dropped == CARD_MAP_ERROR):
		_reset_card_to_starting_position(starting_position, card)
		return
	# card is in a valid play area, either add it or swap if the chosen tile is occupied
	var area_start : CardMap = card_maps[index_card_map_start]
	var tile_start : Vector2i = area_start.get_tile_from_global(starting_position)
	var area_dropped : CardMap = card_maps[index_card_map_dropped]
	var tile_dropped : Vector2i = area_dropped.get_hovered_tile()
	# tile is occupied, swap card with card on the tile
	if(area_dropped.card_grid.is_tile_occupied(tile_dropped)):
		var card_to_swap : Card = area_dropped.card_grid.cards[tile_dropped]
		if(card_to_swap.data.is_locked or card_to_swap.data.is_fixed):
			_reset_card_to_starting_position(starting_position, card)
			return
		area_dropped.card_grid.remove_card(tile_dropped)
		_move_card(card_to_swap, area_start, tile_start)
	# regardless if the tile was occupied, the card gets added
	_move_card(card, area_dropped, tile_dropped)
	return
