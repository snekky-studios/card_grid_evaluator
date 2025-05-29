extends Node
class_name Level

signal board_evaluated(hand_ranks : Array[Hand.Rank]) # hand_ranks = [r0, r1, ..., c0, c1, ...]

const DECK_STANDARD : Deck = preload("res://data/deck/decks/deck_standard.tres")

var deck : Deck = null : set = _set_deck

var board : CardMap = null
var dock : CardMap = null
var card_mover : CardMover = null
var card_spawner : CardSpawner = null

func _ready() -> void:
	board = %Board
	dock = %Dock
	card_mover = %CardMover
	card_spawner = %CardSpawner
	
	deck = DECK_STANDARD
	deck.shuffle()

	card_mover.card_maps.append(board)
	card_mover.card_maps.append(dock)
	
	card_spawner.card_spawned.connect(_on_card_spawner_card_spawned)
	card_spawner.card_not_spawned.connect(_on_card_spawner_card_not_spawned)
	return

func spawn_cards(num_cards : int) -> void:
	for index_card : int in range(num_cards):
		card_spawner.spawn_card(dock, deck.deal())
	return

func evaluate_board() -> void:
	var hand_ranks : Array[Hand.Rank] = []
	for row : int in range(board.num_rows()):
		var row_cards : Array[CardData] = board.card_grid.get_row_of_cards(row)
		var hand_rank : Hand.Rank = Hand.rank(row_cards)
		hand_ranks.append(hand_rank)
	for col : int in range(board.num_cols()):
		var col_cards : Array[CardData] = board.card_grid.get_column_of_cards(col)
		var hand_rank : Hand.Rank = Hand.rank(col_cards)
		hand_ranks.append(hand_rank)
	board_evaluated.emit(hand_ranks)
	return

func _set_deck(value : Deck) -> void:
	deck = value
	if(deck == null):
		deck = DECK_STANDARD
	return

func _on_card_spawner_card_spawned(card : Card) -> void:
	card_mover.setup_card(card)
	return

func _on_card_spawner_card_not_spawned(card_data : CardData) -> void:
	deck.add_card_draw_pile(card_data)
	return
