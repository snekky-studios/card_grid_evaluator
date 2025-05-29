extends Node
class_name Main



var level : Level = null
var ui : UI = null

func _ready() -> void:
	level = %Level
	ui = %UI
	
	level.board_evaluated.connect(_on_board_evaluated)
	
	ui.button_deal_pressed.connect(level.spawn_cards.bind(3))
	ui.button_ok_pressed.connect(level.evaluate_board)
	return

func _on_board_evaluated(hand_ranks : Array[Hand.Rank]) -> void:
	var hand_rank_names : Array[String] = []
	for hand_rank : Hand.Rank in hand_ranks:
		hand_rank_names.append(Hand.RankName[hand_rank])
	ui.update_hand_ranks(hand_rank_names)
	return
