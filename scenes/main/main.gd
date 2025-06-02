extends Node
class_name Main

const RUN_MODIFIER_STANDARD : RunModifier = preload("res://data/modifier/run/run_modifiers/run_modifier_standard.tres")
const DECK_STANDARD : Deck = preload("res://data/deck/decks/deck_standard.tres")
const PAY_TABLE_STANDARD : PayTable = preload("res://data/pay_table/pay_tables/pay_table_standard.tres")
const DEAL_COST_MODIFIER_1_1 : DealCostModifier = preload("res://data/modifier/level/deal_cost/deal_cost_modifiers/deal_cost_modifier_1_1.tres")
const GRID_MODIFIER_TWO_TOWERS : GridModifier = preload("res://data/modifier/level/grid/grid_modifiers/grid_modifier_two_towers.tres")
const GRID_MODIFIER_GONE_FISHING : GridModifier = preload("res://data/modifier/level/grid/grid_modifiers/grid_modifier_gone_fishing.tres")

var level : Level = null

func _ready() -> void:
	level = %Level
	
	var run_data : RunData = RunData.new()
	run_data.load_modifier(RUN_MODIFIER_STANDARD)
	
	var pay_table : PayTable = PAY_TABLE_STANDARD
	
	level.run_data = run_data
	level.pay_table = pay_table
	level.deal_cost_modifier = DEAL_COST_MODIFIER_1_1
	level.grid_modifier = GRID_MODIFIER_GONE_FISHING
	return
