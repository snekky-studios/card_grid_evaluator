extends Resource
class_name Deck

@export var draw_pile : Array[CardData] = [] # pool of cards that are drawn from
var discard_pile : Array[CardData] = [] # pool of card where discards go
var in_use_pile : Array[CardData] = [] # pool of cards that are being used by some other entity (ex. in a hand)
#var index : int = 0 # keeps track of the current "top card" on the deck

func add_card_draw_pile(card : CardData) -> void:
	draw_pile.append(card)
	return

func add_card_discard_pile(card : CardData) -> void:
	discard_pile.append(card)
	return

func add_card_in_use_pile(card : CardData) -> void:
	in_use_pile.append(card)
	return

# removes card from whatever pile it is in, if any
func remove_card(card : CardData) -> void:
	if(card in draw_pile):
		draw_pile.erase(card)
	elif(card in discard_pile):
		discard_pile.erase(card)
	elif(card in in_use_pile):
		in_use_pile.erase(card)
	else:
		print("error: card not found in deck - ", card.to_string(), " : ", card)
	return

func get_full_deck() -> Array[CardData]:
	var full_deck : Array[CardData] = []
	full_deck.append_array(draw_pile)
	full_deck.append_array(discard_pile)
	full_deck.append_array(in_use_pile)
	return full_deck

# sorts the draw_pile array and returns it
# sorts first by suit, smallest to largest [s < h < d < c]
# sorts next by rank, smallest to largest [A < 2 < ... < K]
func sort() -> Array[CardData]:
	# sort by suit
	for index_primary : int in range(draw_pile.size() - 1):
		for index_secondary : int in range(index_primary, draw_pile.size()):
			if(draw_pile[index_primary].suit > draw_pile[index_secondary].suit):
				var card_temp : CardData = draw_pile[index_primary]
				draw_pile[index_primary] = draw_pile[index_secondary]
				draw_pile[index_secondary] = card_temp
	# sort by rank
	var num_draw_pile_of_suit : Array[int] = []
	num_draw_pile_of_suit.resize(CardData.NUM_SUITS)
	num_draw_pile_of_suit.fill(0)
	# count the number of draw_pile of each suit
	for index_draw_pile : int in range(draw_pile.size()):
		num_draw_pile_of_suit[draw_pile[index_draw_pile].suit] += 1
	# loop through each suit and sort by rank within each
	var index_draw_pile : int = 0 # keep track of where we are in the deck overall
	for index_suit : int in range(CardData.NUM_SUITS):
		for index_primary : int in range(index_draw_pile, index_draw_pile + num_draw_pile_of_suit[index_suit] - 1):
			for index_secondary : int in range(index_primary, index_draw_pile + num_draw_pile_of_suit[index_suit]):
				if(draw_pile[index_primary].rank > draw_pile[index_secondary].rank):
					var card_temp : CardData = draw_pile[index_primary]
					draw_pile[index_primary] = draw_pile[index_secondary]
					draw_pile[index_secondary] = card_temp
		index_draw_pile += num_draw_pile_of_suit[index_suit]
	return draw_pile

# shuffles the discard pile back into the draw pile
func shuffle() -> void:
	draw_pile.append_array(discard_pile)
	discard_pile = []
	draw_pile.shuffle()
	return

# returns the top card of the draw_pile or returns null if the draw_pile is empty
func deal() -> CardData:
	if(draw_pile.size() <= 0):
		return null
	return draw_pile.pop_front()

# adds all cards, even those in use, back into the deck
func reset() -> void:
	draw_pile.append_array(discard_pile)
	draw_pile.append_array(in_use_pile)
	discard_pile = []
	in_use_pile = []
	return

# returns the number of cards remaining in draw_pile
func remaining_cards() -> int:
	return draw_pile.size()

func _to_string() -> String:
	var output : String = ""
	var deck : Array[CardData] = get_full_deck()
	for index_card : int in range(deck.size()):
		output += deck[index_card]._to_string() + ","
		if((index_card + 1) % 13 == 0):
			output += "\n"
	return output
