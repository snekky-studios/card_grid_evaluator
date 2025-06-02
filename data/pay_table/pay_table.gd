extends Resource
class_name PayTable

@export var payouts : Dictionary = {
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
