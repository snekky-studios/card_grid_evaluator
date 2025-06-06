extends Resource
class_name LevelData

signal objective_updated(objective : Objective, index_objective : int)
signal objective_completed(payout : int)

var score : int = 0 : set = _set_score
var score_goal : int = 0
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
