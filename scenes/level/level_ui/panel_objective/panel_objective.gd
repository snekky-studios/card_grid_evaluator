extends PanelContainer
class_name PanelObjective

var label_name : Label = null
var label_payout : Label = null
var label_requirement : Label = null
var texture_rect_tiles : TextureRect = null
var fill_tiles_icon : FillTilesIcon = null
var label_progress : Label = null

func _ready() -> void:
	label_name = %LabelName
	label_payout = %LabelPayout
	label_requirement = %LabelRequirement
	texture_rect_tiles = %TextureRectTiles
	fill_tiles_icon = %FillTilesIcon
	label_progress = %LabelProgress
	
	fill_tiles_icon.texture_rect = texture_rect_tiles
	texture_rect_tiles.hide()
	return

# update contents to reflect state of objective
func update(objective : Objective) -> void:
	label_name.text = objective.name
	label_payout.text = "$" + str(objective.payout)
	var requirement_text : String = ""
	match objective.type:
		Objective.Type.MAKE_HAND:
			requirement_text += "Make a "
			if(objective.requirement == Objective.Requirement.SUIT):
				requirement_text += CardData.LUT_SUIT_NAME[objective.suit] + " "
			requirement_text += Hand.RankName[objective.rank]
			if(objective.requirement == Objective.Requirement.CARD_RANK):
				requirement_text += " of " + CardData.LUT_RANK_NAME[objective.card_rank] + "'s"
		Objective.Type.FILL_TILES:
			requirement_text += "Fill tiles:"
			texture_rect_tiles.show()
			fill_tiles_icon.update((objective as ObjectiveFillTiles).tiles_to_place, Color.WHITE)
			fill_tiles_icon.update((objective as ObjectiveFillTiles).tiles_placed, Color.GREEN)
		Objective.Type.PLACE_CARDS:
			requirement_text += str(clamp(objective.num_current, 0, ObjectivePlaceCards.MAX)) + "/" + str(objective.num_max) + " "
			if(objective.suit != CardData.SUIT_ERROR):
				requirement_text += CardData.LUT_SUIT_NAME[objective.suit] + "s placed"
			elif(objective.rank != CardData.RANK_ERROR):
				requirement_text += CardData.LUT_RANK_NAME[objective.rank] + "s placed"
			else:
				print("error: place cards objective does not have a valid suit or rank")
		_:
			print("error: unrecognized objective type - ", objective.type)
	label_requirement.text = requirement_text
	label_progress.text = "Complete" if objective.is_complete else "Incomplete"
	return
