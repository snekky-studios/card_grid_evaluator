extends Node
class_name Game

const DECK_STANDARD : Deck = preload("res://data/deck/decks/deck_standard.tres")

const CELL_SIZE : Vector2 = Vector2(32, 32)
const CELL_SIZE_HALF : Vector2 = 0.5 * CELL_SIZE

var deck : Deck = null
var discard : Deck = null

var board : CardMap = null
var dock : CardMap = null
var card_mover : CardMover = null
#var slot_machine : SlotMachine = null

func _ready() -> void:
	board = %Board
	dock = %Dock
	card_mover = %CardMover
	#slot_machine = %SlotMachine
	deck = DECK_STANDARD
	discard = Deck.new()
	deck.shuffle()
	
	card_mover.card_maps.append(board)
	card_mover.card_maps.append(dock)
	
	#slot_machine.flush_cards.connect(_on_slot_machine_flush_cards)
	#slot_machine.need_cards.connect(_on_slot_machine_need_cards)
	return



#func _on_slot_machine_flush_cards(cards_to_flush: Array[CardData]) -> void:
	#for card : CardData in cards_to_flush:
		#discard.add_card(card)
	#return
#
#func _on_slot_machine_need_cards() -> void:
	#for index_card_slot : int in range(slot_machine.cards.size()):
		#if(deck.remaining_cards() == 0):
			#deck.combine(discard)
		#slot_machine.cards[index_card_slot] = deck.pop()
	#slot_machine.create_cards()
	#return
