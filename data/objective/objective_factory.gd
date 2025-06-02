extends Node
class_name ObjectiveFactory

const dir_path : String = "res://data/objective/objectives/"
const file_prefix : String = "objective_"
const file_suffix : String = ".tres"

const PAYOUT_EASY : int = 10
const PAYOUT_MEDIUM : int = 20
const PAYOUT_HARD : int = 30

static func build_all() -> void:
	var error : Error = OK
	var objective : Objective = null
	var objective_name : String = ""
	
	
	
	error = _save(objective, dir_path + file_prefix + objective_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print("build complete")
	return

static func _save(objective : Objective, file_path : String) -> Error:
	return ResourceSaver.save(objective, file_path)
