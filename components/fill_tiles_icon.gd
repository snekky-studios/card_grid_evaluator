extends Node
class_name FillTilesIcon

var texture_rect : TextureRect = null

# sets specified tiles in the tile indicator texture rect to the specified color
func update(tiles_to_fill : Array[Vector2i], color : Color) -> void:
	var image : Image = texture_rect.texture.get_image()
	var image_texture : ImageTexture = ImageTexture.new()
	for tile : Vector2i in tiles_to_fill:
		image.set_pixel(tile.x, tile.y, color)
	image_texture.set_image(image)
	texture_rect.texture = image_texture
	return
