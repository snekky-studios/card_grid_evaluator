extends Resource
class_name Objective
# Data container for Objectives, which are tasks the player can complete each level
#
# Objectives have a difficulty, which affects what objectives are spawned each level
# Objectives have a payout, which is the amount of money the player receives for completing the objective
# Objectives have variable requirements, organized by type, that must be fulfilled to complete the objective

signal completed(payout : int) # emits when the objective has been completed

enum Type {
	MAKE_HAND, # Make a certain hand rank, optionally of a certain suit/card rank
	FILL_TILES, # Fill certain tiles on the card grid
	PLACE_CARDS # Place a certain amount of a suit or card rank in a row without playing others
}

enum Difficulty {
	EASY,
	MEDIUM,
	HARD
}

const DifficultyName : Dictionary = {
	Difficulty.EASY : "Easy",
	Difficulty.MEDIUM : "Medium",
	Difficulty.HARD : "Hard"
}

var name : String = "" : set = _set_name # name of the objective to be displayed in the UI
var payout : int = 0 : set = _set_payout # how much money the objective returns if completed
var type : Type = Type.MAKE_HAND : set = _set_type
var difficulty : Difficulty = Difficulty.EASY : set = _set_difficulty
var is_complete : bool = false : set = _set_is_complete

# applicable variables if objective type is MAKE_HAND
var make_hand_rank : Hand.Rank = Hand.Rank.NONE : set = _set_make_hand_rank # Hand rank that must be made to complete objective
var make_hand_card_rank : int = CardData.RANK_ERROR : set = _set_make_hand_card_rank # optional - card rank that must be used if hand rank is pair, three of a kind, four of a kind
var make_hand_suit : int = CardData.SUIT_ERROR : set = _set_make_hand_suit # optional - suit that must be used if hand rank is flush, straight flush, flush house, flush five

# applicable variables if objective type is FILL_TILES
var fill_tiles_unplaced : Array[Vector2i] = [] # list of tiles remaining to be placed 
var fill_tiles_placed : Array[Vector2i] = [] # list of tiles that have had cards placed on them

# applicable variables if objective type is PLACE_CARDS
var place_cards_suit : int = CardData.SUIT_ERROR : set = _set_place_cards_suit # suit of cards that must be placed in a row without playing others
var place_cards_rank : int = CardData.RANK_ERROR : set = _set_place_cards_rank # rank of cards that must be placed in a row without playing others
var place_cards_num_max : int = 0 : set = _set_place_cards_num_max # number of cards that must be placed in a row without playing others
var place_cards_num_current : int = 0 : set = _set_place_cards_num_current # current number of cards that have been placed in a row without playing others

#region Common Functions
func _set_name(value : String) -> void:
	name = value
	return

func _set_payout(value : int) -> void:
	payout = value
	return

func _set_type(value : Type) -> void:
	type = value
	return

func _set_difficulty(value : Difficulty) -> void:
	difficulty = value
	return

func _set_is_complete(value : bool) -> void:
	is_complete = value
	return
#endregion

#region MAKE_HAND Functions
func _set_make_hand_rank(value : Hand.Rank) -> void:
	make_hand_rank = value
	return

func _set_make_hand_card_rank(value : int) -> void:
	make_hand_card_rank = value
	return

func _set_make_hand_suit(value : int) -> void:
	make_hand_suit = value
	return
#endregion

#region FILL_TILES Functions

#endregion

#region PLACE_CARDS Functions
func _set_place_cards_suit(value : int) -> void:
	place_cards_suit = value
	return

func _set_place_cards_rank(value : int) -> void:
	place_cards_rank = value
	return

func _set_place_cards_num_max(value : int) -> void:
	place_cards_num_max = value
	return

func _set_place_cards_num_current(value : int) -> void:
	place_cards_num_current = value
	return
#endregion


func _to_string() -> String:
	var output : String = ""
	output += name + "\n"
	output += "Difficulty: " + DifficultyName[difficulty] + "\n"
	match type:
		Type.MAKE_HAND:
			output += "Make a " + Hand.RankName[make_hand_rank]
			if(make_hand_card_rank != CardData.RANK_ERROR):
				output += " of " + CardData.LUT_RANK[make_hand_card_rank] + "'s"
			output += "\n"
		Type.FILL_TILES:
			output += "Fill tiles at "
			for index_tile : int in range(fill_tiles_unplaced.size()):
				output += "(" + str(fill_tiles_unplaced[index_tile].x) + ", " + str(fill_tiles_unplaced[index_tile].y) + ")"
				if(index_tile < fill_tiles_unplaced.size() - 1):
					output += ", "
			output += "\nTiles already filled: "
			for index_tile : int in range(fill_tiles_placed.size()):
				output += "(" + str(fill_tiles_placed[index_tile].x) + ", " + str(fill_tiles_placed[index_tile].y) + ")"
				if(index_tile < fill_tiles_placed.size() - 1):
					output += ", "
			output += "\n"
		Type.PLACE_CARDS:
			output += "Place " + str(place_cards_num_max) + " cards of "
			if(place_cards_suit != CardData.SUIT_ERROR):
				output += "suit " + CardData.LUT_SUIT[place_cards_suit] + " without playing cards of a different suit"
			elif(place_cards_rank != CardData.RANK_ERROR):
				output += "rank " + CardData.LUT_RANK[place_cards_rank] + " without playing cards of a different rank"
			else:
				print("error: place cards objective does not have a valid suit or rank")
			output += "\n"
		_:
			print("error: unrecognized objective type - ", type)
	output += "Payout: $" + str(payout) + "\n"
	output += "Status: " + (is_complete if "Complete\n" else "Incomplete\n")
	return output
