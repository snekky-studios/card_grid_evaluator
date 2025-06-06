extends Control
class_name UI

signal button_deal_pressed
signal button_submit_pressed

const PANEL_OBJECTIVE : PackedScene = preload("res://scenes/ui/panel_objective/panel_objective.tscn")

var panel_objectives : Array[PanelObjective] = []

var button_deal : ButtonDeal = null
var button_submit : ButtonSubmit = null

var label_score : Label = null
var label_money : Label = null

var vbox_container_objectives : VBoxContainer = null

var panel_container_hands : PanelContainer = null
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
	button_submit = %ButtonSubmit
	label_score = %LabelScore
	label_money = %LabelMoney
	vbox_container_objectives = %VBoxContainerObjectives
	panel_container_hands = %PanelContainerHands
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
	
	button_deal.button_deal_pressed.connect(_on_button_deal_pressed)
	button_submit.button_submit_pressed.connect(_on_button_submit_pressed)
	
	create_panel_objectives(5)
	return

func create_panel_objectives(number : int) -> void:
	for index_panel_objective : int in range(number):
		var panel_objective : PanelObjective = PANEL_OBJECTIVE.instantiate()
		vbox_container_objectives.add_child(panel_objective)
		panel_objectives.append(panel_objective)
	return

func update_hand_rank(row : int, col : int, hand_rank_name : String) -> void:
	match row:
		0:
			label_hand_row0.text = hand_rank_name
		1:
			label_hand_row1.text = hand_rank_name
		2:
			label_hand_row2.text = hand_rank_name
		3:
			label_hand_row3.text = hand_rank_name
		4:
			label_hand_row4.text = hand_rank_name
		Globals.NOT_ROW:
			pass
		_:
			print("error: invalid row - ", row)
	match col:
		0:
			label_hand_col0.text = hand_rank_name
		1:
			label_hand_col1.text = hand_rank_name
		2:
			label_hand_col2.text = hand_rank_name
		3:
			label_hand_col3.text = hand_rank_name
		4:
			label_hand_col4.text = hand_rank_name
		Globals.NOT_COL:
			pass
		_:
			print("error: invalid col - ", col)
	
	return

func set_score(value : int) -> void:
	label_score.text = str(value)
	return

func set_money(value : int) -> void:
	label_money.text = "$" + str(value)
	return

func set_objective(objective : Objective, index_objective : int) -> void:
	panel_objectives[index_objective].update(objective)
	return

func _on_button_deal_pressed() -> void:
	button_deal_pressed.emit()
	return

func _on_button_submit_pressed() -> void:
	button_submit_pressed.emit()
	return
