extends Node
class_name LevelBuilder
# Creates a LevelData resource based on desired difficulty

const dir_path_pay_table : String = "res://data/pay_table/pay_tables/"
const file_prefix_pay_table : String = "pay_table_"
const dir_path_grid_modifier : String = "res://data/modifier/level/grid/grid_modifiers/"
const file_prefix_grid_modifier : String = "grid_modifier_"
const dir_path_deal_cost_modifier : String = "res://data/modifier/level/deal_cost/deal_cost_modifiers/"
const file_prefix_deal_cost_modifier : String = "deal_cost_modifier_"
const dir_path_objective : String = "res://data/objective/"
#const dir_path_objective_very_easy : String = "very_easy/"
#const dir_path_objective_easy : String = "easy/"
#const dir_path_objective_medium : String = "medium/"
#const dir_path_objective_hard : String = "hard/"
#const dir_path_objective_very_hard : String = "very_hard/"
#const dir_path_objective_fill_tiles : String = "fill_tiles/"
#const dir_path_objective_make_hand : String = "make_hand/"
#const dir_path_objective_place_cards : String = "place_cards/"
const file_prefix_objective : String = "objective_"
const file_suffix : String = ".tres"

const SCORE_GOAL_DIFFICULTY : Dictionary[LevelData.Difficulty, int] = {
	LevelData.Difficulty.VERY_EASY : 20,
	LevelData.Difficulty.EASY : 40,
	LevelData.Difficulty.MEDIUM : 60,
	LevelData.Difficulty.HARD : 80,
	LevelData.Difficulty.VERY_HARD : 100
}

const PAY_TABLE_NAMES : Array[String] = [
	"standard"
]

const GRID_MODIFIER_NAMES : Array[String] = [
	"standard",
	"crazy_eights",
	"gone_fishing",
	"two_towers"
]

const DEAL_COST_MODIFIER_DIFFICULTY : Dictionary[LevelData.Difficulty, String] = {
	LevelData.Difficulty.VERY_EASY : "1_0",
	LevelData.Difficulty.EASY : "0_1",
	LevelData.Difficulty.MEDIUM : "1_1",
	LevelData.Difficulty.HARD : "2_1",
	LevelData.Difficulty.VERY_HARD : "1_2"
}

const DEAL_COST_MODIFIER_NAMES : Array[String] = [
	"0_1",
	"1_0",
	"1_1"
]

# contains the number of objectives of each objective difficulty level that should be associated with a level of each level difficulty
const OBJECTIVE_DIFFICULTY_AMOUNT : Dictionary[LevelData.Difficulty, Dictionary] = {
	LevelData.Difficulty.VERY_EASY : {
		Objective.Difficulty.VERY_EASY : 2,
		Objective.Difficulty.EASY : 2,
		Objective.Difficulty.MEDIUM : 1,
		Objective.Difficulty.HARD : 0,
		Objective.Difficulty.VERY_HARD : 0
	},
	LevelData.Difficulty.EASY : {
		Objective.Difficulty.VERY_EASY : 1,
		Objective.Difficulty.EASY : 2,
		Objective.Difficulty.MEDIUM : 2,
		Objective.Difficulty.HARD : 0,
		Objective.Difficulty.VERY_HARD : 0
	},
	LevelData.Difficulty.MEDIUM : {
		Objective.Difficulty.VERY_EASY : 1,
		Objective.Difficulty.EASY : 1,
		Objective.Difficulty.MEDIUM : 2,
		Objective.Difficulty.HARD : 1,
		Objective.Difficulty.VERY_HARD : 0
	},
	LevelData.Difficulty.HARD : {
		Objective.Difficulty.VERY_EASY : 0,
		Objective.Difficulty.EASY : 1,
		Objective.Difficulty.MEDIUM : 2,
		Objective.Difficulty.HARD : 2,
		Objective.Difficulty.VERY_HARD : 0
	},
	LevelData.Difficulty.VERY_HARD : {
		Objective.Difficulty.VERY_EASY : 0,
		Objective.Difficulty.EASY : 0,
		Objective.Difficulty.MEDIUM : 2,
		Objective.Difficulty.HARD : 2,
		Objective.Difficulty.VERY_HARD : 1
	},
}

const OBJECTIVE_DIFFICULTY_DIR_PATHS : Dictionary[Objective.Difficulty, String] = {
	Objective.Difficulty.VERY_EASY : "very_easy/",
	Objective.Difficulty.EASY : "easy/",
	Objective.Difficulty.MEDIUM : "medium/",
	Objective.Difficulty.HARD : "hard/",
	Objective.Difficulty.VERY_HARD : "very_hard/"
}

const OBJECTIVE_TYPE_DIR_PATHS : Dictionary[Objective.Type, String] = {
	Objective.Type.FILL_TILES : "fill_tiles/",
	Objective.Type.MAKE_HAND : "make_hand/",
	Objective.Type.PLACE_CARDS : "place_cards/"
}

# creates a new LevelData resource of the given difficulty
static func build(difficulty : LevelData.Difficulty) -> LevelData:
	var level_data : LevelData = LevelData.new()
	level_data.difficulty = difficulty
	level_data.score_goal = _build_score_goal(level_data.difficulty)
	level_data.pay_table = _build_pay_table(level_data.difficulty)
	level_data.grid_modifier = _build_grid_modifier(level_data.difficulty)
	level_data.deal_cost_modifier = _build_deal_cost_modifier(level_data.difficulty)
	var objectives : Array[Objective] = _build_objectives(level_data.difficulty)
	for objective : Objective in objectives:
		# we need to connect objective signals
		level_data.add_objective(objective)
	return level_data

static func _build_score_goal(difficulty : LevelData.Difficulty) -> int:
	var score_goal : int = SCORE_GOAL_DIFFICULTY[difficulty]
	return score_goal

static func _build_pay_table(_difficulty : LevelData.Difficulty) -> PayTable:
	# for now, pay tables are not separated by difficulty, so just pick a random one and load it
	var pay_table_name : String = PAY_TABLE_NAMES.pick_random()
	var pay_table : PayTable = load(dir_path_pay_table + file_prefix_pay_table + pay_table_name + file_suffix)
	return pay_table

static func _build_grid_modifier(_difficulty : LevelData.Difficulty) -> GridModifier:
	# for now, pay tables are not separated by difficulty, so just pick a random one and load it
	var grid_modifier_name : String = GRID_MODIFIER_NAMES.pick_random()
	var grid_modifier : GridModifier = load(dir_path_grid_modifier + file_prefix_grid_modifier + grid_modifier_name + file_suffix)
	return grid_modifier

static func _build_deal_cost_modifier(difficulty : LevelData.Difficulty) -> DealCostModifier:
	var deal_cost_modifier_name : String = DEAL_COST_MODIFIER_DIFFICULTY[difficulty]
	var deal_cost_modifier : DealCostModifier = load(dir_path_deal_cost_modifier + file_prefix_deal_cost_modifier + deal_cost_modifier_name + file_suffix)
	return deal_cost_modifier

static func _build_objectives(difficulty : LevelData.Difficulty) -> Array[Objective]:
	var objectives : Array[Objective] = []
	var objective_difficulties : Dictionary = OBJECTIVE_DIFFICULTY_AMOUNT[difficulty]
	var objective_types : Array[Objective.Type] = [Objective.Type.FILL_TILES, Objective.Type.MAKE_HAND, Objective.Type.PLACE_CARDS]
	# loop through each objective difficulty
	for objective_difficulty : Objective.Difficulty in objective_difficulties.keys():
		# get how many objectives of that difficulty to add
		var num_objectives : int = objective_difficulties[objective_difficulty]
		var dir_path_objective_difficulty : String = OBJECTIVE_DIFFICULTY_DIR_PATHS[objective_difficulty]
		var objectives_already_picked : Array[String] = [] # keeps track of objectives that have already been picked so we don't pick the same one twice
		# add an objective of each difficulty the number of times specified in the dictionary
		for index_objective_difficulty : int in range(num_objectives):
			# pick a random objective type, then choose a random objective of that type and the specified difficulty
			var objective_type : Objective.Type = objective_types.pick_random()
			var dir_path_objective_type : String = OBJECTIVE_TYPE_DIR_PATHS[objective_type]
			var dir_path_objective_full : String = dir_path_objective + dir_path_objective_difficulty + dir_path_objective_type
			var resource_files : PackedStringArray = DirAccess.get_files_at(dir_path_objective_full)
			var file_name_objective : String = resource_files[randi_range(0, resource_files.size() - 1)]
			# make sure we don't pick the same objective twice
			while(file_name_objective in objectives_already_picked):
				file_name_objective = resource_files[randi_range(0, resource_files.size() - 1)]
			objectives_already_picked.append(file_name_objective)
			var objective : Objective = load(dir_path_objective_full + file_name_objective)
			objectives.append(objective)
	return objectives
