extends Node
class_name ObjectiveHandler
# Interface class for Objective resource
#
# Listens for events that may result in objective updates, and updates objectives accordingly

var objectives : Array[Objective] = []

func _ready() -> void:
	return

func set_objectives(objectives_arg : Array[Objective]) -> void:
	objectives = objectives_arg
	return

# checks for MAKE_HAND objective completions
func _on_hand_evaluated(hand_rank : Hand.Rank, card_rank_mode : int, suit_mode : int) -> void:
	for objective : Objective in objectives:
		if(objective.type != Objective.Type.MAKE_HAND):
			continue
		if(objective.is_complete):
			continue
		if(objective.rank == hand_rank):
			if(objective.requirement == Objective.Requirement.NONE):
				# objective has neither card rank nor suit requirement
				objective.is_complete = true
			elif(objective.requirement == Objective.Requirement.SUIT and objective.suit == suit_mode):
				# objective has a suit requirement, and the hand has the most cards of the correct suit
				objective.is_complete = true
			elif(objective.requirement == Objective.Requirement.CARD_RANK and objective.card_rank == card_rank_mode):
				# objective has neither card rank nor suit requirement, so it has been fulfilled if the hand rank matches
				objective.is_complete = true
	return

# checks for FILL_TILES and PLACE_CARDS objective updates
func _on_card_placed(card : CardData, tile : Vector2i) -> void:
	for objective : Objective in objectives:
		if(objective.is_complete):
			continue
		match objective.type:
			Objective.Type.MAKE_HAND:
				continue
			Objective.Type.FILL_TILES:
				# place_tile function contains checks to ensure tile is in correct array
				objective.place_tile(tile)
			Objective.Type.PLACE_CARDS:
				if(objective.requirement == Objective.Requirement.SUIT):
					# "place cards of a certain suit" objective
					if(objective.suit == card.suit):
						objective.num_current += 1
					else:
						# different suited card was played, so objective resets
						objective.num_current = 0
				elif(objective.requirement == Objective.Requirement.CARD_RANK):
					# "place cards of a certain rank" objective
					if(objective.rank == card.rank):
						objective.num_current += 1
					else:
						# different ranked card was played, so objective resets
						objective.num_current = 0
			_:
				print("error: invalid objective type - ", objective.type)
	return

# checks for FILL_TILES and PLACE_CARDS objective updates
func _on_card_removed(card : CardData, tile : Vector2i) -> void:
	for objective : Objective in objectives:
		if(objective.is_complete):
			continue
		match objective.type:
			Objective.Type.MAKE_HAND:
				continue
			Objective.Type.FILL_TILES:
				# remove_tile function contains checks to ensure tile is in correct array
				objective.remove_tile(tile)
			Objective.Type.PLACE_CARDS:
				# this prevents the player from moving the same card over and over to complete the objective
				if(objective.requirement == Objective.Requirement.SUIT and objective.suit == card.suit):
					# "place cards of a certain suit" objective
					objective.num_current -= 1
				elif(objective.requirement == Objective.Requirement.CARD_RANK and objective.rank == card.rank):
					# "place cards of a certain rank" objective
					objective.num_current -= 1
			_:
				print("error: invalid objective type - ", objective.type)
	return


func _on_board_submit() -> void:
	for objective : Objective in objectives:
		if(objective.is_complete):
			continue
		match objective.type:
			Objective.Type.MAKE_HAND:
				continue
			Objective.Type.FILL_TILES:
				if(objective.tiles_to_place.size() == objective.tiles_placed.size()):
					objective.is_complete = true
			Objective.Type.PLACE_CARDS:
				if(objective.num_current >= objective.num_max):
					objective.is_complete = true
			_:
				print("error: invalid objective type - ", objective.type)
	return
