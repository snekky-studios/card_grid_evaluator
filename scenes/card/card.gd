extends Area2D
class_name Card

const SPRITE_SIZE : int = 32
const OUTLINE_COLOR : Color = Color.WHITE
const OUTLINE_THICKNESS : int = 1

var data : CardData = null : set = _set_data

var is_hovered : bool = false : set = _set_is_hovered

var visuals : CanvasGroup = null
var sprite_2d : Sprite2D = null
var drag_and_drop : DragAndDrop = null
var outline_highlighter : OutlineHighlighter = null
var card_locker_fixer : CardLockerFixer = null

func _ready() -> void:
	visuals = %Visuals
	sprite_2d = %Sprite2D
	drag_and_drop = %DragAndDrop
	outline_highlighter = %OutlineHighlighter
	card_locker_fixer = %CardLockerFixer
	
	drag_and_drop.target = self
	drag_and_drop.enabled = true
	drag_and_drop.drag_started.connect(_on_drag_started)
	drag_and_drop.drag_canceled.connect(_on_drag_canceled)
	
	outline_highlighter.visuals = visuals
	outline_highlighter.outline_color = OUTLINE_COLOR
	outline_highlighter.outline_thickness = OUTLINE_THICKNESS
	outline_highlighter.clear_highlight()
	
	card_locker_fixer.color_locked = Color(0.7, 0.7, 0.7)
	card_locker_fixer.color_fixed = Color(1.0, 0.722, 0.82)
	card_locker_fixer.sprite_2d = sprite_2d
	return

func reset_after_dragging(starting_position : Vector2) -> void:
	global_position = starting_position
	return

func _set_data(value : CardData) -> void:
	data = value
	sprite_2d.region_rect.position = Vector2(data.texture_coordinates) * SPRITE_SIZE
	data.locked.connect(_on_data_locked)
	data.unlocked.connect(_on_data_unlocked)
	data.fixed.connect(_on_data_fixed)
	data.unfixed.connect(_on_data_unfixed)
	return

func _set_is_hovered(value : bool) -> void:
	is_hovered = value
	if(is_hovered):
		outline_highlighter.highlight()
		z_index = 1
	else:
		outline_highlighter.clear_highlight()
		z_index = 0
	return

func _on_data_locked() -> void:
	drag_and_drop.enabled = false
	card_locker_fixer.locked = true
	return

func _on_data_unlocked() -> void:
	drag_and_drop.enabled = true
	card_locker_fixer.locked = false
	return

func _on_data_fixed() -> void:
	drag_and_drop.enabled = false
	card_locker_fixer.fixed = true
	return

func _on_data_unfixed() -> void:
	drag_and_drop.enabled = true
	card_locker_fixer.fixed = false
	return

func _on_drag_started() -> void:
	return

func _on_drag_canceled(starting_position : Vector2) -> void:
	reset_after_dragging(starting_position)
	return

func _to_string() -> String:
	return data._to_string()

func _on_mouse_entered() -> void:
	if(drag_and_drop.dragging or data.is_locked or data.is_fixed):
		return
	is_hovered = true
	return

func _on_mouse_exited() -> void:
	if(drag_and_drop.dragging):
		return
	is_hovered = false
	return
