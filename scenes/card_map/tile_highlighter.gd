extends Node
class_name TileHighlighter

var enabled : bool = false : set = _set_enabled
var card_map : CardMap = null : set = _set_card_map
var highlight_layer : TileMapLayer = null
var tile : Vector2i = Vector2i.ZERO

var source_id : int = 0

func _ready() -> void:
	return

func _process(_delta : float) -> void:
	if(not enabled):
		return
	var selected_tile : Vector2i = card_map.get_hovered_tile()
	if(not card_map.is_tile_in_bounds(selected_tile)):
		highlight_layer.clear()
		return
	_update_tile(selected_tile)
	return

func _set_enabled(value : bool) -> void:
	enabled = value
	if(not enabled and card_map):
		highlight_layer.clear()
	return

func _set_card_map(value : CardMap) -> void:
	card_map = value
	source_id = card_map.tile_set.get_source_id(0)
	return

func _update_tile(selected_tile : Vector2i) -> void:
	highlight_layer.clear()
	highlight_layer.set_cell(selected_tile, source_id, tile)
	return
