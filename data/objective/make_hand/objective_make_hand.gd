extends Objective
class_name ObjectiveMakeHand

@export var rank : Hand.Rank = Hand.Rank.NONE # Hand rank that must be made to complete objective
@export var card_rank : int = CardData.RANK_ERROR # optional - card rank that must be used if hand rank is pair, three of a kind, four of a kind
@export var suit : int = CardData.SUIT_ERROR # optional - suit that must be used if hand rank is flush, straight flush, flush house, flush five

func _to_string() -> String:
	var output : String = ""
	output += name + "\n"
	output += "Difficulty: " + DifficultyName[difficulty] + "\n"
	output += "Make a "
	if(requirement == Objective.Requirement.SUIT):
		output += CardData.LUT_SUIT_NAME[suit] + " "
	output += Hand.RankName[rank]
	if(requirement == Objective.Requirement.CARD_RANK):
		output += " of " + CardData.LUT_RANK_NAME[card_rank] + "s"
	output += "\n"
	output += "Payout: $" + str(payout) + "\n"
	output += "Status: " + ("Complete" if is_complete else "Incomplete")
	return output
