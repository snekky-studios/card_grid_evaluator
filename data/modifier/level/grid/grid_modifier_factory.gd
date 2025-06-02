extends Node
class_name GridModifierFactory

#region Card Preloads
const card_As : CardData = preload("res://data/card/cards/card_As.tres")
const card_2s : CardData = preload(("res://data/card/cards/card_2s.tres"))
const card_3s : CardData = preload(("res://data/card/cards/card_3s.tres"))
const card_4s : CardData = preload(("res://data/card/cards/card_4s.tres"))
const card_5s : CardData = preload(("res://data/card/cards/card_5s.tres"))
const card_6s : CardData = preload(("res://data/card/cards/card_6s.tres"))
const card_7s : CardData = preload(("res://data/card/cards/card_7s.tres"))
const card_8s : CardData = preload(("res://data/card/cards/card_8s.tres"))
const card_9s : CardData = preload(("res://data/card/cards/card_9s.tres"))
const card_Ts : CardData = preload(("res://data/card/cards/card_Ts.tres"))
const card_Js : CardData = preload(("res://data/card/cards/card_Js.tres"))
const card_Qs : CardData = preload(("res://data/card/cards/card_Qs.tres"))
const card_Ks : CardData = preload(("res://data/card/cards/card_Ks.tres"))
const card_Ah : CardData = preload("res://data/card/cards/card_Ah.tres")
const card_2h : CardData = preload(("res://data/card/cards/card_2h.tres"))
const card_3h : CardData = preload(("res://data/card/cards/card_3h.tres"))
const card_4h : CardData = preload(("res://data/card/cards/card_4h.tres"))
const card_5h : CardData = preload(("res://data/card/cards/card_5h.tres"))
const card_6h : CardData = preload(("res://data/card/cards/card_6h.tres"))
const card_7h : CardData = preload(("res://data/card/cards/card_7h.tres"))
const card_8h : CardData = preload(("res://data/card/cards/card_8h.tres"))
const card_9h : CardData = preload(("res://data/card/cards/card_9h.tres"))
const card_Th : CardData = preload(("res://data/card/cards/card_Th.tres"))
const card_Jh : CardData = preload(("res://data/card/cards/card_Jh.tres"))
const card_Qh : CardData = preload(("res://data/card/cards/card_Qh.tres"))
const card_Kh : CardData = preload(("res://data/card/cards/card_Kh.tres"))
const card_Ad : CardData = preload("res://data/card/cards/card_Ad.tres")
const card_2d : CardData = preload(("res://data/card/cards/card_2d.tres"))
const card_3d : CardData = preload(("res://data/card/cards/card_3d.tres"))
const card_4d : CardData = preload(("res://data/card/cards/card_4d.tres"))
const card_5d : CardData = preload(("res://data/card/cards/card_5d.tres"))
const card_6d : CardData = preload(("res://data/card/cards/card_6d.tres"))
const card_7d : CardData = preload(("res://data/card/cards/card_7d.tres"))
const card_8d : CardData = preload(("res://data/card/cards/card_8d.tres"))
const card_9d : CardData = preload(("res://data/card/cards/card_9d.tres"))
const card_Td : CardData = preload(("res://data/card/cards/card_Td.tres"))
const card_Jd : CardData = preload(("res://data/card/cards/card_Jd.tres"))
const card_Qd : CardData = preload(("res://data/card/cards/card_Qd.tres"))
const card_Kd : CardData = preload(("res://data/card/cards/card_Kd.tres"))
const card_Ac : CardData = preload("res://data/card/cards/card_Ac.tres")
const card_2c : CardData = preload(("res://data/card/cards/card_2c.tres"))
const card_3c : CardData = preload(("res://data/card/cards/card_3c.tres"))
const card_4c : CardData = preload(("res://data/card/cards/card_4c.tres"))
const card_5c : CardData = preload(("res://data/card/cards/card_5c.tres"))
const card_6c : CardData = preload(("res://data/card/cards/card_6c.tres"))
const card_7c : CardData = preload(("res://data/card/cards/card_7c.tres"))
const card_8c : CardData = preload(("res://data/card/cards/card_8c.tres"))
const card_9c : CardData = preload(("res://data/card/cards/card_9c.tres"))
const card_Tc : CardData = preload(("res://data/card/cards/card_Tc.tres"))
const card_Jc : CardData = preload(("res://data/card/cards/card_Jc.tres"))
const card_Qc : CardData = preload(("res://data/card/cards/card_Qc.tres"))
const card_Kc : CardData = preload(("res://data/card/cards/card_Kc.tres"))
#endregion

const dir_path : String = "res://data/modifier/level/grid/grid_modifiers/"
const file_prefix : String = "grid_modifier_"
const file_suffix : String = ".tres"

static func build(grid_modifier_name : String) -> void:
	var error : Error = OK
	var grid_modifier : GridModifier = GridModifier.new()
	
	# set all cards to null initially
	for index_row : int in range(Globals.GRID_NUM_ROWS):
		for index_col : int in range(Globals.GRID_NUM_COLS):
			set_card(grid_modifier, index_row, index_col, null)
	
	match grid_modifier_name:
		"standard":
			pass
		"two_towers":
			set_card(grid_modifier, 0, 0, card_2c)
			set_card(grid_modifier, 1, 0, card_2s)
			set_card(grid_modifier, 3, 4, card_2h)
			set_card(grid_modifier, 4, 4, card_2d)
		"crazy_eights":
			set_card(grid_modifier, 0, 4, card_8s)
			set_card(grid_modifier, 1, 1, card_8h)
			set_card(grid_modifier, 3, 3, card_8d)
			set_card(grid_modifier, 4, 0, card_8c)
		"gone_fishing":
			set_card(grid_modifier, 0, 3, card_Jc)
			set_card(grid_modifier, 1, 3, card_2d)
			set_card(grid_modifier, 2, 3, card_7s)
			set_card(grid_modifier, 3, 1, card_Jd)
			set_card(grid_modifier, 3, 3, card_Ah)
			set_card(grid_modifier, 4, 2, card_Js)
		_:
			print("error: unrecognized grid modifier name - ", grid_modifier_name)
	
	error = _save(grid_modifier, dir_path + file_prefix + grid_modifier_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print("build complete")
	return

static func set_card(grid_modifier : GridModifier, row : int, col : int, card : CardData) -> void:
	grid_modifier.cards[Vector2i(col, row)] = card
	return

static func _save(grid_modifier : GridModifier, file_path : String) -> Error:
	return ResourceSaver.save(grid_modifier, file_path)
