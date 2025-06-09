extends Resource
class_name PayTable

@export var payouts : Dictionary[Hand.Rank, int] = {
	Hand.Rank.NONE: 0,
	Hand.Rank.HIGH_CARD: 0,
	Hand.Rank.PAIR: 0,
	Hand.Rank.TWO_PAIR: 0,
	Hand.Rank.THREE_OF_A_KIND: 0,
	Hand.Rank.STRAIGHT: 0,
	Hand.Rank.FLUSH: 0,
	Hand.Rank.FULL_HOUSE: 0,
	Hand.Rank.FOUR_OF_A_KIND: 0,
	Hand.Rank.STRAIGHT_FLUSH: 0
}

func _to_string() -> String:
	var output : String = ""
	for index_payout : int in range(payouts.size()):
		output += Hand.RankName[index_payout as Hand.Rank] + ": " + str(payouts[index_payout as Hand.Rank])
		if(index_payout < payouts.size() - 1):
			output += "\n"
	return output
