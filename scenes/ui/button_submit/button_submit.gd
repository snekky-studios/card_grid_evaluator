extends Area2D
class_name ButtonSubmit

signal button_submit_pressed

var visuals : CanvasGroup = null
var outline_highlighter : OutlineHighlighter = null

var disabled : bool = false
var is_hovered : bool = false
var mouse_is_dragging_object : bool = false

func _ready() -> void:
	visuals = %Visuals
	outline_highlighter = %OutlineHighlighter
	
	outline_highlighter.visuals = visuals
	outline_highlighter.clear_highlight()
	
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	return

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and is_hovered:
		button_submit_pressed.emit()

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
