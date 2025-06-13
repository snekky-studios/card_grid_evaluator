extends Area2D
class_name ButtonDeal

signal button_deal_pressed

var visuals : CanvasGroup = null
var sprite_2d : Sprite2D = null
var outline_highlighter : OutlineHighlighter = null
var hbox_money : HBoxContainer = null
var label_cost : Label = null
var animation_player : AnimationPlayer = null

var disabled : bool = false
var is_hovered : bool = false
var mouse_is_dragging_object : bool = false

func _ready() -> void:
	visuals = %Visuals
	sprite_2d = %Sprite2D
	outline_highlighter = %OutlineHighlighter
	hbox_money = %HBoxMoney
	label_cost = %LabelCost
	animation_player = %AnimationPlayer
	
	outline_highlighter.visuals = visuals
	outline_highlighter.clear_highlight()
	
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	return

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and is_hovered:
		button_deal_pressed.emit()

func set_cost(cost : int) -> void:
	label_cost.text = str(cost)
	return

func flash() -> void:
	animation_player.play("flash")
	return

func _on_area_entered(_area : Area2D) -> void:
	mouse_is_dragging_object = true
	return

func _on_area_exited(_area : Area2D) -> void:
	mouse_is_dragging_object = false
	return

func _on_mouse_entered() -> void:
	# we don't want to highlight if the mouse is holding something
	if not disabled and not mouse_is_dragging_object:
		is_hovered = true
		outline_highlighter.highlight()
	return

func _on_mouse_exited() -> void:
	is_hovered = false
	outline_highlighter.clear_highlight()
	return
