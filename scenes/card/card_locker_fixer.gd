extends Node
class_name CardLockerFixer

var sprite_2d : Sprite2D = null : set = _set_sprite_2d
var locked : bool = false : set = _set_locked
var fixed : bool = false : set = _set_fixed

var color_replace : Color = Color.WHITE
var color_locked : Color = Color(0.7, 0.7, 0.7)
var color_fixed : Color = Color(0.5, 0.5, 0.5)

func _ready() -> void:
	
	return

func _set_sprite_2d(value : Sprite2D) -> void:
	sprite_2d = value
	if(sprite_2d):
		sprite_2d.material.set_shader_parameter("u_color_replace", color_replace)
		sprite_2d.material.set_shader_parameter("u_color_locked", color_locked)
		sprite_2d.material.set_shader_parameter("u_color_fixed", color_fixed)
	return

func _set_locked(value : bool) -> void:
	locked = value
	if(sprite_2d):
		sprite_2d.material.set_shader_parameter("u_locked", locked)
	return

func _set_fixed(value : bool) -> void:
	fixed = value
	if(sprite_2d):
		sprite_2d.material.set_shader_parameter("u_fixed", fixed)
	return
