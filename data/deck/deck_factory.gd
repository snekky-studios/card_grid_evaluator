# Utility class that generates decks and saves them to resource files
extends Node
class_name DeckFactory

const dir_path : String = "res://data/deck/decks/"
const file_prefix : String = "deck_"
const file_name : String = "standard"
const file_suffix : String = ".tres"

static func build() -> Deck:
	var error : Error = OK
	var deck : Deck = Deck.new()
	for index_suit : int in range(CardData.NUM_SUITS):
		for index_rank : int in range(CardData.NUM_RANKS):
			var card : CardData = CardData.new()
			card.rank = index_rank
			card.suit = index_suit
			deck.add_card_draw_pile(card)
	error = _save(deck, dir_path + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	return deck

static func _save(deck : Deck, file_path : String) -> Error:
	return ResourceSaver.save(deck, file_path)
