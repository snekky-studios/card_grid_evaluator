extends Resource
class_name LevelData

signal objective_updated(objective : Objective, index_objective : int)
signal objective_completed(payout : int)

const NUM_OBJECTIVES : int = 5

enum Difficulty {
	VERY_EASY,
	EASY,
	MEDIUM,
	HARD,
	VERY_HARD
}

var score : int = 0 : set = _set_score
var score_goal : int = 0
var difficulty : Difficulty = Difficulty.VERY_EASY
var deal_cost : int = 0
var pay_table : PayTable = null
var grid_modifier : GridModifier = null
var deal_cost_modifier : DealCostModifier = null : set = _set_deal_cost_modifier
var objectives : Array[Objective] = []

func add_objective(objective : Objective) -> void:
	objectives.append(objective)
	objective.updated.connect(_on_objective_updated)
	objective.completed.connect(_on_objective_completed)
	return

func _set_score(value : int) -> void:
	score = value
	changed.emit()
	return

func _set_deal_cost_modifier(value : DealCostModifier) -> void:
	deal_cost_modifier = value
	deal_cost = deal_cost_modifier.initial_cost
	return

func _on_objective_updated(objective : Objective) -> void:
	var index_objective : int = objectives.find(objective)
	objective_updated.emit(objective, index_objective)
	return

func _on_objective_completed(payout : int) -> void:
	objective_completed.emit(payout)
	return

func _to_string() -> String:
	var output : String = ""
	output += "Difficulty: " + str(difficulty) + "\n"
	output += "Score Goal: " + str(score_goal) + "\n"
	output += deal_cost_modifier._to_string() + "\n"
	output += "Pay Table:\n" + pay_table._to_string() + "\n"
	output += "Grid Modifier:\n" + grid_modifier._to_string() + "\n"
	output += "Objectives:\n"
	for index_objective : int in range(objectives.size()):
		output += "Objective " + str(index_objective) + ":\n" + objectives[index_objective]._to_string()
		if(index_objective < objectives.size() - 1):
			output += "\n"
	return output
