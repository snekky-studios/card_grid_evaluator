extends Node
class_name ObjectiveFactory

const dir_path : String = "res://data/objective/objectives/"
const file_prefix : String = "objective_"
const file_suffix : String = ".tres"

const PAYOUT_VERY_EASY : int = 10
const PAYOUT_EASY : int = 20
const PAYOUT_MEDIUM : int = 30
const PAYOUT_HARD : int = 40
const PAYOUT_VERY_HARD : int = 50

const FILL_TILES_MIN : int = 1
const FILL_TILES_MAX : int = 8

const PLACE_CARDS_RANK_MIN : int = 1
const PLACE_CARDS_RANK_MAX : int = 6
const PLACE_CARDS_SUIT_MIN : int = 1
const PLACE_CARDS_SUIT_MAX : int = 13

const HAND_RANK_FILE_NAME : Dictionary = {
	Hand.Rank.PAIR : "pair",
	Hand.Rank.TWO_PAIR : "two_pair",
	Hand.Rank.THREE_OF_A_KIND : "three_of_a_kind",
	Hand.Rank.STRAIGHT : "straight",
	Hand.Rank.FLUSH : "flush",
	Hand.Rank.FULL_HOUSE : "full_house",
	Hand.Rank.FOUR_OF_A_KIND : "four_of_a_kind",
	Hand.Rank.STRAIGHT_FLUSH : "straight_flush",
	Hand.Rank.FIVE_OF_A_KIND : "five_of_a_kind",
	Hand.Rank.FLUSH_HOUSE : "flush_house",
	Hand.Rank.FLUSH_FIVE : "flush_five"
}

const HAND_RANK_OBJECTIVE_NAME : Dictionary = {
	Hand.Rank.PAIR : "Pair",
	Hand.Rank.TWO_PAIR : "Two Pair",
	Hand.Rank.THREE_OF_A_KIND : "Three of a Kind",
	Hand.Rank.STRAIGHT : "Straight",
	Hand.Rank.FLUSH : "Flush",
	Hand.Rank.FULL_HOUSE : "Full House",
	Hand.Rank.FOUR_OF_A_KIND : "Four of a Kind",
	Hand.Rank.STRAIGHT_FLUSH : "Straight Flush",
	Hand.Rank.FIVE_OF_A_KIND : "Five of a Kind",
	Hand.Rank.FLUSH_HOUSE : "Flush House",
	Hand.Rank.FLUSH_FIVE : "Flush Five"
}

const FILL_TILE_OBJECTIVE_NAME : Dictionary = {
	"triangle" : "Triangle",
	"v" : "V",
	"four_corners" : "Four Corners",
	"compass" : "Compass",
	"border" : "Border",
	"center" : "Center"
}

static func build_make_hand(hand_rank : Hand.Rank, card_rank : CardData.Rank, suit : CardData.Suit) -> void:
	var error : Error = OK
	var dir_folder : String = "make_hand/"
	var file_name : String = "make_hand_" + HAND_RANK_FILE_NAME[hand_rank]
	var objective : Objective = Objective.new()
	objective.name = HAND_RANK_OBJECTIVE_NAME[hand_rank]
	objective.type = Objective.Type.MAKE_HAND
	objective.make_hand_rank = hand_rank
	objective.make_hand_card_rank = card_rank
	objective.make_hand_suit = suit
	
	# set objective difficulty and build objective name + file name
	if(objective.make_hand_card_rank != CardData.RANK_ERROR):
		# objective has a card rank requirement
		file_name += "_" + CardData.LUT_RANK[objective.make_hand_card_rank]
		objective.name += " of " + CardData.LUT_RANK_NAME[objective.make_hand_card_rank] + "s"
		match objective.make_hand_rank:
			Hand.Rank.PAIR:
				objective.difficulty = Objective.Difficulty.EASY
			Hand.Rank.THREE_OF_A_KIND:
				objective.difficulty = Objective.Difficulty.MEDIUM
			Hand.Rank.FOUR_OF_A_KIND:
				objective.difficulty = Objective.Difficulty.HARD
			Hand.Rank.FIVE_OF_A_KIND:
				objective.difficulty = Objective.Difficulty.VERY_HARD
			Hand.Rank.FLUSH_FIVE:
				objective.difficulty = Objective.Difficulty.VERY_HARD
			_:
				print("error: hand rank incompatible with card rank requirement - ", objective.make_hand_rank)
	elif(objective.make_hand_suit != CardData.SUIT_ERROR):
		# objective has a suit requirement
		file_name += "_" + CardData.LUT_SUIT[objective.make_hand_suit]
		# overwrite objective name, this particular case has a different format (ex. Spade Flush instead of Flush of Spades)
		objective.name = CardData.LUT_SUIT_NAME[objective.make_hand_suit] + " " + HAND_RANK_OBJECTIVE_NAME[hand_rank]
		match objective.make_hand_rank:
			Hand.Rank.FLUSH:
				objective.difficulty = Objective.Difficulty.MEDIUM
			Hand.Rank.STRAIGHT_FLUSH:
				objective.difficulty = Objective.Difficulty.VERY_HARD
			Hand.Rank.FLUSH_HOUSE:
				objective.difficulty = Objective.Difficulty.VERY_HARD
			Hand.Rank.FLUSH_FIVE:
				objective.difficulty = Objective.Difficulty.VERY_HARD
			_:
				print("error: hand rank incompatible with suit requirement - ", objective.make_hand_rank)
	else:
		# objective has no card rank or suit requirement
		match objective.make_hand_rank:
			Hand.Rank.PAIR:
				objective.difficulty = Objective.Difficulty.VERY_EASY
			Hand.Rank.TWO_PAIR:
				objective.difficulty = Objective.Difficulty.VERY_EASY
			Hand.Rank.THREE_OF_A_KIND:
				objective.difficulty = Objective.Difficulty.VERY_EASY
			Hand.Rank.STRAIGHT:
				objective.difficulty = Objective.Difficulty.EASY
			Hand.Rank.FLUSH:
				objective.difficulty = Objective.Difficulty.EASY
			Hand.Rank.FULL_HOUSE:
				objective.difficulty = Objective.Difficulty.EASY
			Hand.Rank.FOUR_OF_A_KIND:
				objective.difficulty = Objective.Difficulty.MEDIUM
			Hand.Rank.STRAIGHT_FLUSH:
				objective.difficulty = Objective.Difficulty.MEDIUM
			Hand.Rank.FIVE_OF_A_KIND:
				objective.difficulty = Objective.Difficulty.HARD
			Hand.Rank.FLUSH_HOUSE:
				objective.difficulty = Objective.Difficulty.HARD
			Hand.Rank.FLUSH_FIVE:
				objective.difficulty = Objective.Difficulty.HARD
			_:
				print("error: invalid hand rank - ", objective.make_hand_rank)
		pass
	
	# set objective payout
	match objective.difficulty:
		Objective.Difficulty.VERY_EASY:
			objective.payout = PAYOUT_VERY_EASY
		Objective.Difficulty.EASY:
			objective.payout = PAYOUT_EASY
		Objective.Difficulty.MEDIUM:
			objective.payout = PAYOUT_MEDIUM
		Objective.Difficulty.HARD:
			objective.payout = PAYOUT_HARD
		Objective.Difficulty.VERY_HARD:
			objective.payout = PAYOUT_VERY_HARD
		_:
			print("error: invalid objective difficulty - ", objective.difficulty)
	
	objective.is_complete = false
	
	error = _save(objective, dir_path + dir_folder + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print("build completed: ", objective.name)
	return

static func build_make_hand_all() -> void:
	for hand_rank : Hand.Rank in Hand.Rank.values():
		match hand_rank:
			Hand.Rank.NONE:
				# skip the NONE rank, since it is for errors/debugging
				pass
			Hand.Rank.HIGH_CARD:
				# no objectives for High Card
				pass
			Hand.Rank.PAIR:
				for card_rank : int in CardData.RANKS:
					build_make_hand(hand_rank, card_rank, CardData.SUIT_ERROR)
			Hand.Rank.TWO_PAIR:
				build_make_hand(hand_rank, CardData.RANK_ERROR, CardData.SUIT_ERROR)
			Hand.Rank.THREE_OF_A_KIND:
				for card_rank : int in CardData.RANKS:
					build_make_hand(hand_rank, card_rank, CardData.SUIT_ERROR)
			Hand.Rank.STRAIGHT:
				build_make_hand(hand_rank, CardData.RANK_ERROR, CardData.SUIT_ERROR)
			Hand.Rank.FLUSH:
				for suit : int in CardData.SUITS:
					build_make_hand(hand_rank, CardData.RANK_ERROR, suit)
			Hand.Rank.FULL_HOUSE:
				build_make_hand(hand_rank, CardData.RANK_ERROR, CardData.SUIT_ERROR)
			Hand.Rank.FOUR_OF_A_KIND:
				for card_rank : int in CardData.RANKS:
					build_make_hand(hand_rank, card_rank, CardData.SUIT_ERROR)
			Hand.Rank.STRAIGHT_FLUSH:
				for suit : int in CardData.SUITS:
					build_make_hand(hand_rank, CardData.RANK_ERROR, suit)
			Hand.Rank.FIVE_OF_A_KIND:
				for card_rank : int in CardData.RANKS:
					build_make_hand(hand_rank, card_rank, CardData.SUIT_ERROR)
			Hand.Rank.FLUSH_HOUSE:
				for suit : int in CardData.SUITS:
					build_make_hand(hand_rank, CardData.RANK_ERROR, suit)
			Hand.Rank.FLUSH_FIVE:
				for suit : int in CardData.SUITS:
					build_make_hand(hand_rank, CardData.RANK_ERROR, suit)
				for card_rank : int in CardData.RANKS:
					build_make_hand(hand_rank, card_rank, CardData.SUIT_ERROR)
			_:
				print("error: invalid hand rank - ", hand_rank)
	print("build complete: make hand all")
	return

static func build_fill_tile(objective_name : String, tiles : Array[Vector2i], difficulty : Objective.Difficulty) -> void:
	var error : Error = OK
	var dir_folder : String = "fill_tiles/"
	var file_name : String = "fill_tiles_" + objective_name
	var objective : Objective = Objective.new()
	
	# set objective name
	if(objective_name in FILL_TILE_OBJECTIVE_NAME.keys()):
		objective.name = FILL_TILE_OBJECTIVE_NAME[objective_name]
	elif(objective_name.contains("row")):
		var row_string : String = objective_name[4] # row is always at index 4 in row_Y strings
		objective.name = "Row " + row_string
	elif(objective_name.contains("col")):
		var col_string : String = objective_name[4] # col is always at index 4 in col_X strings
		objective.name = "Col " + col_string
	elif(objective_name.contains("cross")):
		var col_string : String = objective_name[6] # col is always at index 6 in cross_XY strings
		var row_string : String = objective_name[7] # row is always at index 7 in cross_XY strings
		objective.name = "Cross " + col_string + row_string
	else:
		print("error: invalid tile fill objective name - ", objective_name)
		return
	
	objective.type = Objective.Type.FILL_TILES
	objective.difficulty = difficulty
	objective.fill_tiles_unplaced = []
	objective.fill_tiles_placed = []
	
	# add given tiles to unplaced tiles list
	for tile : Vector2i in tiles:
		objective.fill_tiles_unplaced.append(tile)
	
	# set objective payout
	match objective.difficulty:
		Objective.Difficulty.VERY_EASY:
			objective.payout = PAYOUT_VERY_EASY
		Objective.Difficulty.EASY:
			objective.payout = PAYOUT_EASY
		Objective.Difficulty.MEDIUM:
			objective.payout = PAYOUT_MEDIUM
		Objective.Difficulty.HARD:
			objective.payout = PAYOUT_HARD
		Objective.Difficulty.VERY_HARD:
			objective.payout = PAYOUT_VERY_HARD
		_:
			print("error: invalid objective difficulty - ", objective.difficulty)
	
	objective.is_complete = false
	
	error = _save(objective, dir_path + dir_folder + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print("build completed: ", objective.name)
	return

static func build_fill_tile_all() -> void:
	var objective_name : String = ""
	var tiles : Array[Vector2i] = []
	var difficulty : Objective.Difficulty = Objective.Difficulty.VERY_EASY
	
	# very easy fill tile objectives (Custom, Row Y, Col X)
	objective_name = "triangle"
	tiles = []
	tiles.append(Vector2i(2, 0))
	tiles.append(Vector2i(0, 4))
	tiles.append(Vector2i(4, 4))
	difficulty = Objective.Difficulty.VERY_EASY
	build_fill_tile(objective_name, tiles, difficulty)
	
	objective_name = "v"
	tiles = []
	tiles.append(Vector2i(1, 0))
	tiles.append(Vector2i(3, 0))
	tiles.append(Vector2i(2, 4))
	difficulty = Objective.Difficulty.VERY_EASY
	build_fill_tile(objective_name, tiles, difficulty)
	
	objective_name = "four_corners"
	tiles = []
	tiles.append(Vector2i(0, 0))
	tiles.append(Vector2i(4, 0))
	tiles.append(Vector2i(0, 4))
	tiles.append(Vector2i(4, 4))
	difficulty = Objective.Difficulty.VERY_EASY
	build_fill_tile(objective_name, tiles, difficulty)
	
	objective_name = "compass"
	tiles = []
	tiles.append(Vector2i(2, 0))
	tiles.append(Vector2i(0, 2))
	tiles.append(Vector2i(4, 2))
	tiles.append(Vector2i(2, 4))
	difficulty = Objective.Difficulty.VERY_EASY
	build_fill_tile(objective_name, tiles, difficulty)
	
	for row : int in range(Globals.GRID_NUM_ROWS):
		objective_name = "row_" + str(row + 1) # in UI, rows columns are labeled 1-5 rather than 0-4
		tiles = []
		for tile_col : int in range(Globals.GRID_NUM_COLS):
			var tile : Vector2i = Vector2i(tile_col, row)
			tiles.append(tile)
		build_fill_tile(objective_name, tiles, difficulty)
	
	for col : int in range(Globals.GRID_NUM_COLS):
		objective_name = "col_" + str(col + 1) # in UI, rows columns are labeled 1-5 rather than 0-4
		tiles = []
		for tile_row : int in range(Globals.GRID_NUM_ROWS):
			var tile : Vector2i = Vector2i(col, tile_row)
			tiles.append(tile)
		build_fill_tile(objective_name, tiles, difficulty)
	
	# easy fill tile objectives (Cross XY)
	for row : int in range(Globals.GRID_NUM_ROWS):
		for col : int in range(Globals.GRID_NUM_COLS):
			objective_name = "cross_" + str(col + 1) + str(row + 1) # in UI, rows columns are labeled 1-5 rather than 0-4
			tiles = []
			for tile_row : int in range(Globals.GRID_NUM_ROWS):
				var tile : Vector2i = Vector2i(col, tile_row)
				tiles.append(tile)
			for tile_col : int in range(Globals.GRID_NUM_COLS):
				var tile : Vector2i = Vector2i(tile_col, row)
				if(not tile in tiles):
					# we do not want to include the duplicate where row and col intersect
					tiles.append(tile)
			difficulty = Objective.Difficulty.EASY
			build_fill_tile(objective_name, tiles, difficulty)
	
	# medium fill tile objectives
	objective_name = "border"
	tiles = []
	for tile_row : int in range(Globals.GRID_NUM_ROWS):
		var tile : Vector2i = Vector2i(0, tile_row)
		tiles.append(tile)
		tile = Vector2i(4, tile_row)
		tiles.append(tile)
	for tile_col : int in range(1, Globals.GRID_NUM_COLS - 1):
		# only looping 1-3 because we already did cols 0 and 4 above
		var tile : Vector2i = Vector2i(tile_col, 0)
		tiles.append(tile)
		tile = Vector2i(tile_col, 4)
		tiles.append(tile)
	difficulty = Objective.Difficulty.MEDIUM
	build_fill_tile(objective_name, tiles, difficulty)
	
	objective_name = "center"
	tiles = []
	for tile_row : int in range(1, Globals.GRID_NUM_ROWS - 1):
		for tile_col : int in range(1, Globals.GRID_NUM_COLS - 1):
			var tile : Vector2i = Vector2i(tile_col, tile_row)
			tiles.append(tile)
	difficulty = Objective.Difficulty.MEDIUM
	build_fill_tile(objective_name, tiles, difficulty)
	
	print("build complete: fill tile all")
	return

static func build_place_cards(card_rank : CardData.Rank, suit : CardData.Suit, number : int) -> void:
	var error : Error = OK
	var dir_folder : String = "place_cards/"
	var file_name : String = "place_cards_"
	var objective : Objective = Objective.new()
	objective.type = Objective.Type.PLACE_CARDS
	objective.place_cards_rank = card_rank
	objective.place_cards_suit = suit
	objective.place_cards_num_current = 0
	objective.place_cards_num_max = number
	
	# set file name, objective name, and difficulty
	if(objective.place_cards_rank != CardData.RANK_ERROR):
		file_name += CardData.LUT_RANK[objective.place_cards_rank] + str(number)
		objective.name = "Place " + str(number) + " " + CardData.LUT_RANK_NAME[objective.place_cards_rank]
		if(objective.place_cards_num_max != 1):
			# for grammar purposes
			if(objective.place_cards_rank == 5):
				# rank 6 need an e after the x for the plural form
				objective.name += "e"
			objective.name += "s in a Row"
		match objective.place_cards_num_max:
			1:
				objective.difficulty = Objective.Difficulty.VERY_EASY
			2:
				objective.difficulty = Objective.Difficulty.EASY
			3:
				objective.difficulty = Objective.Difficulty.MEDIUM
			4:
				objective.difficulty = Objective.Difficulty.HARD
			5:
				objective.difficulty = Objective.Difficulty.HARD
			6:
				objective.difficulty = Objective.Difficulty.VERY_HARD
			_:
				print("error: invalid number given to place cards (rank) - ", number)
	elif(objective.place_cards_suit != CardData.SUIT_ERROR):
		file_name += CardData.LUT_SUIT[objective.place_cards_suit] + str(number)
		objective.name = "Place " + str(number) + " " + CardData.LUT_SUIT_NAME[objective.place_cards_suit]
		if(objective.place_cards_num_max != 1):
			# for grammar purposes
			objective.name += "s in a Row"
		match objective.place_cards_num_max:
			1:
				objective.difficulty = Objective.Difficulty.VERY_EASY
			2:
				objective.difficulty = Objective.Difficulty.VERY_EASY
			3:
				objective.difficulty = Objective.Difficulty.EASY
			4:
				objective.difficulty = Objective.Difficulty.EASY
			5:
				objective.difficulty = Objective.Difficulty.EASY
			6:
				objective.difficulty = Objective.Difficulty.MEDIUM
			7:
				objective.difficulty = Objective.Difficulty.MEDIUM
			8:
				objective.difficulty = Objective.Difficulty.MEDIUM
			9:
				objective.difficulty = Objective.Difficulty.HARD
			10:
				objective.difficulty = Objective.Difficulty.HARD
			11:
				objective.difficulty = Objective.Difficulty.HARD
			12:
				objective.difficulty = Objective.Difficulty.VERY_HARD
			13:
				objective.difficulty = Objective.Difficulty.VERY_HARD
			_:
				print("error: invalid number given to place cards (suit) - ", number)
	else:
		print("error: build_place_cards not supplied with either rank or suit data")
	
	# set objective payout
	match objective.difficulty:
		Objective.Difficulty.VERY_EASY:
			objective.payout = PAYOUT_VERY_EASY
		Objective.Difficulty.EASY:
			objective.payout = PAYOUT_EASY
		Objective.Difficulty.MEDIUM:
			objective.payout = PAYOUT_MEDIUM
		Objective.Difficulty.HARD:
			objective.payout = PAYOUT_HARD
		Objective.Difficulty.VERY_HARD:
			objective.payout = PAYOUT_VERY_HARD
		_:
			print("error: invalid objective difficulty - ", objective.difficulty)
	
	objective.is_complete = false
	
	error = _save(objective, dir_path + dir_folder + file_prefix + file_name + file_suffix)
	assert(error == OK, "Save error: " + str(error))
	print("build completed: ", objective.name)
	return

static func build_place_cards_all() -> void:
	for card_rank : int in CardData.RANKS:
		for number : int in range(1, 7): # 1-6 inclusive
			build_place_cards(card_rank, CardData.SUIT_ERROR, number)
	for suit : int in CardData.SUITS:
		for number : int in range(1, 14): # 1-13 inclusive
			build_place_cards(CardData.RANK_ERROR, suit, number)
	print("build complete: place cards all")
	return

static func build() -> void:
	var start_time_us : int = Time.get_ticks_usec()
	build_make_hand_all()
	build_fill_tile_all()
	build_place_cards_all()
	var end_time_us : int = Time.get_ticks_usec()
	print("build took: ", end_time_us - start_time_us, "us")
	return

static func _save(objective : Objective, file_path : String) -> Error:
	return ResourceSaver.save(objective, file_path)
