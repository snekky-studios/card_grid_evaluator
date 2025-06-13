extends HBoxContainer
class_name ContainerObjective

var label_payout : Label = null
var label_name : Label = null
var texture_rect_tiles : TextureRect = null
var fill_tiles_icon : FillTilesIcon = null

func _ready() -> void:
	label_payout = %LabelPayout
	label_name = %LabelName
	texture_rect_tiles = %TextureRectTiles
	fill_tiles_icon = %FillTilesIcon
	
	custom_minimum_size.y = 10
	texture_rect_tiles.custom_minimum_size = Vector2(10, 10)
	fill_tiles_icon.texture_rect = texture_rect_tiles
	texture_rect_tiles.hide()
	return

func update(objective : Objective) -> void:
	label_payout.text = "$" + str(objective.payout)
	label_name.text = objective.name
	if(objective.type == Objective.Type.FILL_TILES):
		texture_rect_tiles.show()
		fill_tiles_icon.update((objective as ObjectiveFillTiles).tiles_to_place, Color.WHITE)
	return
