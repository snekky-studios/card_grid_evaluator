extends Control
class_name UI

signal button_deal_pressed
signal button_ok_pressed

var button_deal : Button = null
var button_ok : Button = null

var label_hand_row0 : Label = null
var label_hand_row1 : Label = null
var label_hand_row2 : Label = null
var label_hand_row3 : Label = null
var label_hand_row4 : Label = null
var label_hand_col0 : Label = null
var label_hand_col1 : Label = null
var label_hand_col2 : Label = null
var label_hand_col3 : Label = null
var label_hand_col4 : Label = null

func _ready() -> void:
	button_deal = %ButtonDeal
	button_ok = %ButtonOK
	label_hand_row0 = %LabelHandRow0
	label_hand_row1 = %LabelHandRow1
	label_hand_row2 = %LabelHandRow2
	label_hand_row3 = %LabelHandRow3
	label_hand_row4 = %LabelHandRow4
	label_hand_col0 = %LabelHandCol0
	label_hand_col1 = %LabelHandCol1
	label_hand_col2 = %LabelHandCol2
	label_hand_col3 = %LabelHandCol3
	label_hand_col4 = %LabelHandCol4
	
	button_deal.pressed.connect(_on_button_deal_pressed)
	button_ok.pressed.connect(_on_button_ok_pressed)
	return

func _on_button_deal_pressed() -> void:
	button_deal_pressed.emit()
	return

func _on_button_ok_pressed() -> void:
	button_ok_pressed.emit()
	return

func update_hand_ranks(hand_rank_names : Array[String]) -> void:
	label_hand_row0.text = hand_rank_names[0]
	label_hand_row1.text = hand_rank_names[1]
	label_hand_row2.text = hand_rank_names[2]
	label_hand_row3.text = hand_rank_names[3]
	label_hand_row4.text = hand_rank_names[4]
	label_hand_col0.text = hand_rank_names[5]
	label_hand_col1.text = hand_rank_names[6]
	label_hand_col2.text = hand_rank_names[7]
	label_hand_col3.text = hand_rank_names[8]
	label_hand_col4.text = hand_rank_names[9]
	return
