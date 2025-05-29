extends Node
class_name Hand

enum Rank {
	NONE,
	HIGH_CARD,
	PAIR,
	TWO_PAIR,
	THREE_OF_A_KIND,
	STRAIGHT,
	FLUSH,
	FULL_HOUSE,
	FOUR_OF_A_KIND,
	STRAIGHT_FLUSH,
	FIVE_OF_A_KIND,
	FLUSH_HOUSE,
	FLUSH_FIVE
}

const RankName : Dictionary = {
	Rank.NONE : "NONE",
	Rank.HIGH_CARD : "HIGH CARD",
	Rank.PAIR : "PAIR",
	Rank.TWO_PAIR : "TWO PAIR",
	Rank.THREE_OF_A_KIND : "THREE OF A KIND",
	Rank.STRAIGHT : "STRAIGHT",
	Rank.FLUSH : "FLUSH",
	Rank.FULL_HOUSE : "FULL HOUSE",
	Rank.FOUR_OF_A_KIND : "FOUR_OF A KIND",
	Rank.STRAIGHT_FLUSH : "STRAIGHT FLUSH",
	Rank.FIVE_OF_A_KIND : "FIVE OF A KIND",
	Rank.FLUSH_HOUSE : "FLUSH HOUSE",
	Rank.FLUSH_FIVE : "FLUSH FIVE"
}

const NUM_RANKS : int = 12
const NUM_CARDS_FULL_HAND : int = 5

func _ready() -> void:
	return

# sorts the hand by rank
static func sort(hand : Array[CardData]) -> Array[CardData]:
	var hand_sorted : Array[CardData] = []
	hand_sorted.resize(hand.size())
	for index_hand : int in range(hand.size()):
		hand_sorted[index_hand] = hand[index_hand]
	for index_primary : int in range(hand_sorted.size() - 1):
		for index_secondary : int in range(index_primary + 1, hand_sorted.size()):
			if(hand_sorted[index_primary].rank > hand_sorted[index_secondary].rank):
				var card_temp : CardData = hand_sorted[index_primary]
				hand_sorted[index_primary] = hand_sorted[index_secondary]
				hand_sorted[index_secondary] = card_temp
	return hand_sorted

# evaluates the hand and returns its rank
static func rank(hand : Array[CardData]) -> Rank:
	var hand_size : int = hand.size() # avoids repeated .size() calls
	
	# no cards in hand, or too many cards, therefore no hand rank
	if(hand_size == 0 or hand_size > NUM_CARDS_FULL_HAND):
		return Rank.NONE
	
	# one card in hand, therefore must be highcard
	if(hand_size == 1):
		return Rank.HIGH_CARD
	
	var hand_sorted : Array[CardData] = sort(hand)
	
	# store these in variables to avoid processing more than once
	var is_flush : bool = is_flush(hand_sorted)
	var is_straight : bool = is_straight(hand_sorted)
	
	# check for straight flush and flush
	if(is_flush and is_straight):
		return Rank.STRAIGHT_FLUSH
	elif(is_flush):
		return Rank.FLUSH
	
	# check for straight
	if(is_straight):
		return Rank.STRAIGHT
	
	var counter : Array[int] = []
	counter.resize(CardData.NUM_RANKS)
	counter.fill(0)
	var pairs : int = 0
	var triples : int = 0
	
	# count how many of each rank appears in the hand
	for index_hand : int in range(hand_size):
		counter[hand_sorted[index_hand].rank] += 1
	
	# check for four of a kinds, three of a kinds, and pairs
	for index_counter : int in range(CardData.NUM_RANKS):
		if(counter[index_counter] == 4):
			return Rank.FOUR_OF_A_KIND
		elif(counter[index_counter] == 3):
			triples += 1
		elif(counter[index_counter] == 2):
			pairs += 1
	
	# check for full house and three of a kind
	if(triples == 1):
		if(pairs == 1):
			return Rank.FULL_HOUSE
		else:
			return Rank.THREE_OF_A_KIND
	
	# check for two pair
	if(pairs == 2):
		return Rank.TWO_PAIR
	
	# check for pair
	if(pairs == 1):
		return Rank.PAIR
	
	# was not anything else, must be high card
	return Rank.HIGH_CARD

# returns true if the hand has five cards of the same suit, false otherwise
static func is_flush(hand : Array[CardData]) -> bool:
	# only a full 5 card hand can be a flush
	if(hand.size() != NUM_CARDS_FULL_HAND):
		return false
	for index_hand : int in range(1, NUM_CARDS_FULL_HAND):
		if(hand[0].suit != hand[index_hand].suit):
			return false
	return true

# returns true if the hand has five sequential cards, false otherwise
static func is_straight(hand : Array[CardData]) -> bool:
	# only a full 5 card hand can be a straight
	if(hand.size() != NUM_CARDS_FULL_HAND):
		return false
	# check for ace high straight first
	if(hand[0].rank == CardData.RANK_ACE and
		hand[1].rank == CardData.RANK_TEN and
		hand[2].rank == CardData.RANK_JACK and
		hand[3].rank == CardData.RANK_QUEEN and
		hand[4].rank == CardData.RANK_KING):
		return true
	# now check for general case
	for index_hand : int in range(NUM_CARDS_FULL_HAND - 1):
		if(hand[index_hand].rank != hand[index_hand + 1].rank - 1):
			return false
	return true

# returns a combined string of the cards in hand
static func hand_to_string(hand : Array[CardData]) -> String:
	var output : String = ""
	for index_hand : int in range(hand.size()):
		output += hand[index_hand]._to_string() + ","
	return output
