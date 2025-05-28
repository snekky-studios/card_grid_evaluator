extends Node
class_name DragAndDrop

signal drag_canceled(starting_position : Vector2)
signal drag_started
signal dropped(starting_position : Vector2)

var enabled : bool = true : set = _set_enabled
var target : Area2D = null : set = _set_target

var starting_position : Vector2 = Vector2.ZERO
var offset : Vector2 = Vector2.ZERO
var dragging : bool = false

func _ready() -> void:
	return

func _process(_delta: float) -> void:
	if(dragging and target):
		target.global_position = target.get_global_mouse_position() + offset
	return

func _input(event : InputEvent) -> void:
	if(dragging and target and event.is_action_pressed("cancel_drag")):
		_cancel_dragging()
	elif(dragging and event.is_action_released("select")):
		_drop()
	return

func _set_enabled(value : bool) -> void:
	enabled = value
	return

func _set_target(value : Area2D) -> void:
	target = value
	target.input_event.connect(_on_target_input_event)
	return

func _end_dragging() -> void:
	dragging = false
	target.remove_from_group("dragging")
	target.z_index = 0
	return

func _cancel_dragging() -> void:
	_end_dragging()
	drag_canceled.emit(starting_position)
	return

func _start_dragging() -> void:
	dragging = true
	starting_position = target.global_position
	target.add_to_group("dragging")
	# always draw dragged objects on top
	target.z_index = 99
	offset = target.global_position - target.get_global_mouse_position()
	drag_started.emit()
	return

func _drop() -> void:
	_end_dragging()
	dropped.emit(starting_position)
	return

func _on_target_input_event(_viewport : Node, event : InputEvent, _shape_idx : int) -> void:
	if(not enabled):
		return
	var dragging_object : Node = get_tree().get_first_node_in_group("dragging")
	if(not dragging and dragging_object):
		# there is already an object being dragged, so don't drag this one
		return
	if(not dragging and event.is_action_pressed("select")):
		_start_dragging()
	return
