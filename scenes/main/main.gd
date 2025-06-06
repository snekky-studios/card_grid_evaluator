extends Node
class_name Main

const RUN_MODIFIER_STANDARD : RunModifier = preload("res://data/modifier/run/run_modifiers/run_modifier_standard.tres")
const DECK_STANDARD : Deck = preload("res://data/deck/decks/deck_standard.tres")
const PAY_TABLE_STANDARD : PayTable = preload("res://data/pay_table/pay_tables/pay_table_standard.tres")
const DEAL_COST_MODIFIER_1_1 : DealCostModifier = preload("res://data/modifier/level/deal_cost/deal_cost_modifiers/deal_cost_modifier_1_1.tres")
const GRID_MODIFIER_STANDARD : GridModifier = preload("res://data/modifier/level/grid/grid_modifiers/grid_modifier_standard.tres")
const GRID_MODIFIER_TWO_TOWERS : GridModifier = preload("res://data/modifier/level/grid/grid_modifiers/grid_modifier_two_towers.tres")
const GRID_MODIFIER_GONE_FISHING : GridModifier = preload("res://data/modifier/level/grid/grid_modifiers/grid_modifier_gone_fishing.tres")

var level : Level = null

func _ready() -> void:
	level = %Level
	
	var run_data : RunData = RunData.new()
	run_data.load_modifier(RUN_MODIFIER_STANDARD)
	
	var pay_table : PayTable = PAY_TABLE_STANDARD
	var o0 : Objective = load("res://data/objective/make_hand/objectives/objective_make_hand_pair.tres")
	var o1 : Objective = load("res://data/objective/make_hand/objectives/objective_make_hand_flush_d.tres")
	var o2 : Objective = load("res://data/objective/fill_tiles/objectives/objective_fill_tiles_col_1.tres")
	var o3 : Objective = load("res://data/objective/fill_tiles/objectives/objective_fill_tiles_v.tres")
	var o4 : Objective = load("res://data/objective/place_cards/objectives/objective_place_cards_c4.tres")
	
	var level_data : LevelData = LevelData.new()
	level_data.pay_table = pay_table
	level_data.deal_cost_modifier = DEAL_COST_MODIFIER_1_1
	level_data.grid_modifier = GRID_MODIFIER_STANDARD
	level_data.add_objective(o0)
	level_data.add_objective(o1)
	level_data.add_objective(o2)
	level_data.add_objective(o3)
	level_data.add_objective(o4)
	
	
	level.run_data = run_data
	level.data = level_data
	return
