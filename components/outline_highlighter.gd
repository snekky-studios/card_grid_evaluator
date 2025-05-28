extends Node
class_name OutlineHighlighter

var visuals : CanvasGroup = null : set = _set_visuals
var outline_color : Color = Color.WHITE : set = _set_outline_color
var outline_thickness : int = 1 : set = _set_outline_thickness

func _ready() -> void:
	return

func clear_highlight() -> void:
	visuals.material.set_shader_parameter("line_thickness", 0)
	return

func highlight() -> void:
	visuals.material.set_shader_parameter("line_thickness", outline_thickness)
	return

func _set_visuals(value : CanvasGroup) -> void:
	visuals = value
	return

func _set_outline_color(value : Color) -> void:
	outline_color = value
	if(visuals):
		visuals.material.set_shader_parameter("line_color", outline_color)
	return

func _set_outline_thickness(value : int) -> void:
	outline_thickness = value
	if(visuals):
		visuals.material.set_shader_parameter("line_thickness", outline_thickness)
	return
