extends Node
class_name RunData

signal deck_changed(deck : Deck)
signal money_changed(money : int)

var deck : Deck = null : set = _set_deck
var money : int = 0 : set = _set_money

func setup(starting_deck : Deck, starting_money : int) -> void:
	deck = starting_deck
	money = starting_money
	return

func load_modifier(run_modifier : RunModifier) -> void:
	deck = run_modifier.starting_deck
	money = run_modifier.starting_money
	return

func _set_deck(value : Deck) -> void:
	deck = value
	deck_changed.emit(deck)
	return

func _set_money(value : int) -> void:
	money = value
	money_changed.emit(money)
	return
