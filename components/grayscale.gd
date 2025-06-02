extends Node
class_name Grayscale

var sprite_2d : Sprite2D = null : set = _set_sprite_2d
var enabled : bool = false : set = _set_enabled
var intensity : float = 1.0 : set = _set_intensity

func _set_sprite_2d(value : Sprite2D) -> void:
	sprite_2d = value
	return

func _set_enabled(value : bool) -> void:
	enabled = value
	if(sprite_2d):
		sprite_2d.material.set_shader_parameter("u_enabled", enabled)
	return

func _set_intensity(value : float) -> void:
	intensity = value
	if(sprite_2d):
		sprite_2d.material.set_shader_parameter("u_intensity", intensity)
	return
