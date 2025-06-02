extends Node
class_name CardSpawner

const CARD : PackedScene = preload("res://scenes/card/card.tscn")

signal card_spawned(card : Card)
signal card_not_spawned(card_data : CardData)

func _ready() -> void:
	return

func spawn_card(card_map : CardMap, card_data : CardData) -> void:
	if(not card_map):
		print("error: spawn card invalid area")
		return
	var tile : Vector2i = card_map.card_grid.get_first_empty_tile()
	if(tile == CardGrid.TILE_ERROR):
		card_not_spawned.emit(card_data)
		print("error: no available tiles to spawn card")
		return
	var new_card : Card = CARD.instantiate()
	card_map.card_grid.add_child(new_card)
	card_map.card_grid.add_card(tile, new_card)
	new_card.global_position = card_map.get_global_from_tile(tile) - Globals.CELL_SIZE_HALF
	new_card.data = card_data
	card_spawned.emit(new_card)
	return

func spawn_card_at_tile(card_map : CardMap, card_data : CardData, tile : Vector2i) -> void:
	if(not card_map):
		print("error: spawn card invalid area")
		return
	if(tile == CardGrid.TILE_ERROR):
		card_not_spawned.emit(card_data)
		print("error: bad tile given as argument - ", tile)
		return
	var new_card : Card = CARD.instantiate()
	card_map.card_grid.add_child(new_card)
	card_map.card_grid.add_card(tile, new_card)
	new_card.global_position = card_map.get_global_from_tile(tile) - Globals.CELL_SIZE_HALF
	new_card.data = card_data
	card_spawned.emit(new_card)
	return
