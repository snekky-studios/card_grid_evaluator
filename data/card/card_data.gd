extends Resource
class_name CardData

const LUT_RANK : Array[String] = ['A', '2', '3', '4', '5', '6', '7', '8', '9', 'T', 'J', 'Q', 'K', 'E']
const LUT_SUIT : Array[String] = ['s', 'h', 'd', 'c', 'e']

const NUM_RANKS : int = 13
const NUM_SUITS : int = 4

const RANK_ACE : int = 0
const RANK_TEN : int = 9
const RANK_JACK : int = 10
const RANK_QUEEN : int = 11
const RANK_KING : int = 12
const RANK_ERROR : int = 13

const SUIT_SPADE : int = 0
const SUIT_HEART : int = 1
const SUIT_DIAMOND : int = 2
const SUIT_CLUB : int = 3
const SUIT_ERROR : int = 4

@export var rank : int = RANK_ERROR : set = _set_rank
@export var suit : int = RANK_ERROR : set = _set_suit

var texture_coordinates : Vector2i = Vector2i.ZERO

func _set_rank(value : int) -> void:
	rank = value
	texture_coordinates.x = rank
	return

func _set_suit(value : int) -> void:
	suit = value
	texture_coordinates.y = suit
	return

func _to_string() -> String:
	return LUT_RANK[rank] + LUT_SUIT[suit]
