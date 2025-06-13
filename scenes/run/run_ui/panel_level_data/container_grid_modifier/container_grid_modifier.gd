extends GridContainer
class_name ContainerGridModifier

#const GRID_MODIFIER_CRAZY_EIGHTS : GridModifier = preload("res://data/modifier/level/grid/grid_modifiers/grid_modifier_crazy_eights.tres")
#const GRID_MODIFIER_GONE_FISHING : GridModifier = preload("res://data/modifier/level/grid/grid_modifiers/grid_modifier_gone_fishing.tres")
#const GRID_MODIFIER_STANDARD : GridModifier = preload("res://data/modifier/level/grid/grid_modifiers/grid_modifier_standard.tres")
#const GRID_MODIFIER_TWO_TOWERS : GridModifier = preload("res://data/modifier/level/grid/grid_modifiers/grid_modifier_two_towers.tres")

const UI_THEME : Theme = preload("res://assets/themes/ui_theme.tres")
const STYLEBOX_CONTAINER_GRID_MODIFIER : StyleBoxFlat = preload("res://scenes/run/run_ui/panel_level_data/container_grid_modifier/stylebox_container_grid_modifier.tres")

const EMPTY_CELL : String = "**"

var labels : Dictionary[Vector2i, Label] = {}

func _ready() -> void:
	columns = Globals.GRID_NUM_COLS
	custom_minimum_size = Vector2(71, 71)
	theme = UI_THEME
	add_theme_constant_override("h_separation", -1)
	add_theme_constant_override("v_separation", -1)
	return

func build_grid(grid_modifier : GridModifier) -> void:
	for index_row : int in range(Globals.GRID_NUM_ROWS):
		for index_col : int in range(Globals.GRID_NUM_COLS):
			var panel_container : PanelContainer = PanelContainer.new()
			var label : Label = Label.new()
			var card_data : CardData = grid_modifier.cards[Vector2i(index_col, index_row)]
			panel_container.theme = UI_THEME
			panel_container.add_theme_stylebox_override("panel", STYLEBOX_CONTAINER_GRID_MODIFIER)
			panel_container.custom_minimum_size.x = 15
			panel_container.custom_minimum_size.y = 15
			label.theme = UI_THEME
			label.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
			if(card_data):
				label.text = card_data._to_string()
			else:
				label.text = EMPTY_CELL
			panel_container.add_child(label)
			add_child(panel_container)
			labels[Vector2i(index_col, index_row)] = label
	return
