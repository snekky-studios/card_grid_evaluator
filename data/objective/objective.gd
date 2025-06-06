extends Resource
class_name Objective
# Data container for Objectives, which are tasks the player can complete each level
#
# Objectives have a difficulty, which affects what objectives are spawned each level
# Objectives have a payout, which is the amount of money the player receives for completing the objective
# Objectives have variable requirements, organized by type, that must be fulfilled to complete the objective

signal updated(objective : Objective) # emits when this objective has updated
signal completed(payout : int) # emits when this objective has been completed

enum Type {
	NONE,
	MAKE_HAND, # Make a certain hand rank, optionally of a certain suit/card rank
	FILL_TILES, # Fill certain tiles on the card grid
	PLACE_CARDS # Place a certain amount of a suit or card rank in a row without playing others
}

enum Requirement {
	NONE,
	SUIT,
	CARD_RANK
}

enum Difficulty {
	VERY_EASY,
	EASY,
	MEDIUM,
	HARD,
	VERY_HARD
}

const DifficultyName : Dictionary = {
	Difficulty.VERY_EASY : "Very Easy",
	Difficulty.EASY : "Easy",
	Difficulty.MEDIUM : "Medium",
	Difficulty.HARD : "Hard",
	Difficulty.VERY_HARD : "Very Hard"
}

@export var name : String = "" # name of the objective to be displayed in the UI
@export var type : Type = Type.NONE
@export var requirement : Requirement = Requirement.NONE
@export var difficulty : Difficulty = Difficulty.VERY_EASY
@export var payout : int = 0 # how much money the objective returns if completed
@export var is_complete : bool = false : set = _set_is_complete

func _set_is_complete(value : bool) -> void:
	is_complete = value
	updated.emit(self)
	if(is_complete):
		completed.emit(payout)
	return
