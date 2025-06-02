extends Node
class_name CardDataFactory

const dir_path : String = "res://data/card/cards/"
const file_prefix : String = "card_"
const file_suffix : String = ".tres"

static func build() -> void:
	var error : Error = OK
	for index_suit : int in range(CardData.NUM_SUITS):
		for index_rank : int in range(CardData.NUM_RANKS):
			var card : CardData = CardData.new()
			var file_name : String = str(CardData.LUT_RANK[index_rank]) + str(CardData.LUT_SUIT[index_suit])
			card.rank = index_rank
			card.suit = index_suit
			card.is_locked = false
			card.is_fixed = false
			error = _save(card, dir_path + file_prefix + file_name + file_suffix)
			assert(error == OK, "Save error: " + str(error))
	return

static func _save(card : CardData, file_path : String) -> Error:
	return ResourceSaver.save(card, file_path)
