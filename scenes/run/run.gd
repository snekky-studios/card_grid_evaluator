extends Node
class_name Run

const NUM_LEVEL_CHOICES : int = 3

const LEVEL : PackedScene = preload("res://scenes/level/level.tscn")

enum State {
	NONE,
	PICKING_LEVEL,
	IN_LEVEL,
	PICKING_REWARD
}

var data : RunData = null : set = _set_data
var state : State = State.NONE : set = _set_state
var level_difficulty : LevelData.Difficulty = LevelData.Difficulty.VERY_EASY # how difficult the current level is

var ui : RunUI = null

func _ready() -> void:
	ui = %RunUi
	return

func _set_data(value : RunData) -> void:
	data = value
	return

func _set_state(value : State) -> void:
	state = value
	_on_state_changed()
	return

func _create_level_choices() -> void:
	for index_level_choice : int in range(NUM_LEVEL_CHOICES):
		var level_data : LevelData = LevelBuilder.build(level_difficulty)
		
	return

func _on_state_changed() -> void:
	match state:
		State.PICKING_LEVEL:
			pass
		State.IN_LEVEL:
			pass
		State.PICKING_REWARD:
			pass
		_:
			print("error: invalid state - ", state)
	return
