extends TileMapLayer
class_name CardMap

const TILE_HIGHLIGHT_COORDINATES : Vector2i = Vector2i(0, 0)

var bounds : Rect2i

@export var grid_size : Vector2i = Vector2.ZERO

var card_grid : CardGrid = null
var tile_highlighter : TileHighlighter = null
var tile_map_highlight : TileMapLayer = null

func _ready() -> void:
	card_grid = %CardGrid
	tile_highlighter = %TileHighlighter
	tile_map_highlight = %TileMapHighlight
	
	bounds = Rect2i(Vector2.ZERO, grid_size)
	
	card_grid.size = grid_size
	
	tile_highlighter.enabled = true
	tile_highlighter.card_map = self
	tile_highlighter.highlight_layer = tile_map_highlight
	tile_highlighter.tile = TILE_HIGHLIGHT_COORDINATES
	return

func num_rows() -> int:
	return grid_size.y

func num_cols() -> int:
	return grid_size.x

func get_tile_from_global(global : Vector2) -> Vector2i:
	return local_to_map(to_local(global))

func get_global_from_tile(tile : Vector2i) -> Vector2:
	return to_global(map_to_local(tile))

func get_hovered_tile() -> Vector2i:
	return local_to_map(get_local_mouse_position())

func is_tile_in_bounds(tile : Vector2i) -> bool:
	return bounds.has_point(tile)
