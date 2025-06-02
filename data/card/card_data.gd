extends Resource
class_name CardData

signal locked
signal unlocked
signal fixed
signal unfixed

enum Rank {
	ACE = 0,
	TWO = 1,
	THREE = 2,
	FOUR = 3,
	FIVE = 4,
	SIX = 5,
	SEVEN = 6,
	EIGHT = 7,
	NINE = 8,
	TEN = 9,
	JACK = 10,
	QUEEN = 11,
	KING = 12,
	ERROR = 13
}

enum Suit {
	SPADE = 0,
	HEART = 1,
	DIAMOND = 2,
	CLUB = 3,
	ERROR = 4
}

const RankName : Dictionary = {
	Rank.ACE : "A",
	Rank.TWO : "2",
	Rank.THREE : "3",
	Rank.FOUR : "4",
	Rank.FIVE : "5",
	Rank.SIX : "6",
	Rank.SEVEN : "7",
	Rank.EIGHT : "8",
	Rank.NINE : "9",
	Rank.TEN : "T",
	Rank.JACK : "J",
	Rank.QUEEN : "Q",
	Rank.KING : "K",
	Rank.ERROR : "E",
}

const SuitName : Dictionary = {
	Suit.SPADE : "s",
	Suit.HEART : "h",
	Suit.DIAMOND : "d",
	Suit.CLUB : "c",
	Suit.ERROR : "e"
}

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
var is_locked : bool = false : set = _set_is_locked # cards lock when they are played and scored
var is_fixed : bool = false : set = _set_is_fixed # cards are fixed when they start on the grid

var texture_coordinates : Vector2i = Vector2i.ZERO

func _set_rank(value : int) -> void:
	rank = value
	texture_coordinates.x = rank
	return

func _set_suit(value : int) -> void:
	suit = value
	texture_coordinates.y = suit
	return

func _set_is_locked(value : bool) -> void:
	is_locked = value
	if(is_locked):
		locked.emit()
	else:
		unlocked.emit()
	return

func _set_is_fixed(value : bool) -> void:
	is_fixed = value
	if(is_fixed):
		fixed.emit()
	else:
		unfixed.emit()
	return

func _to_string() -> String:
	return LUT_RANK[rank] + LUT_SUIT[suit]
