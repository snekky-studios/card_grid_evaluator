extends Objective
class_name ObjectivePlaceCards

const MAX : int = 13

@export var suit : int = CardData.SUIT_ERROR # suit of cards that must be placed in a row without playing others
@export var rank : int = CardData.RANK_ERROR # rank of cards that must be placed in a row without playing others
@export var num_max : int = 0 # number of cards that must be placed in a row without playing others
@export var num_current : int = 0 : set = _set_num_current # current number of cards that have been placed in a row without playing others

func _set_num_current(value : int) -> void:
	num_current = value
	updated.emit(self)
	return

func _to_string() -> String:
	var output : String = ""
	output += name + "\n"
	output += "Difficulty: " + DifficultyName[difficulty] + "\n"
	output += "Place " + str(num_max) + " cards of "
	if(requirement == Objective.Requirement.SUIT):
		output += "suit " + CardData.LUT_SUIT_NAME[suit] + " without playing cards of a different suit"
	elif(requirement == Objective.Requirement.CARD_RANK):
		output += "rank " + CardData.LUT_RANK_NAME[rank] + " without playing cards of a different rank"
	else:
		print("error: place cards objective does not have a valid suit or rank")
	output += "\n"
	output += "Payout: $" + str(payout) + "\n"
	output += "Status: " + ("Complete" if is_complete else "Incomplete")
	return output
