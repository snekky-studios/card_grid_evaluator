extends PanelContainer
class_name PanelLevelData

const THEME_NORMAL : Theme = preload("res://assets/themes/ui_theme.tres")
const THEME_HOVERED : Theme = preload("res://assets/themes/panel_level_data_hovered.tres")
const THEME_SELECTED : Theme = preload("res://assets/themes/panel_level_data_selected.tres")
const CONTAINER_OBJECTIVE : PackedScene = preload("res://scenes/run/run_ui/panel_level_data/container_objective/container_objective.tscn")

var is_hovered : bool = false : set = _set_is_hovered
var is_selected : bool = false : set = _set_is_selected

var container_grid_modifier : ContainerGridModifier = null
var vbox_container_objectives : VBoxContainer = null

func _ready() -> void:
	container_grid_modifier = %ContainerGridModifier
	vbox_container_objectives = %VBoxContainerObjectives
	var level_data : LevelData = LevelBuilder.build(LevelData.Difficulty.EASY)
	build(level_data)
	return

func _unhandled_input(event: InputEvent) -> void:
	if(event is InputEventMouseButton and event.is_pressed()):
		is_selected = not is_selected
	return

func _set_is_hovered(value : bool) -> void:
	is_hovered = value
	if(is_hovered):
		theme = THEME_HOVERED
	else:
		if(is_selected):
			theme = THEME_SELECTED
		else:
			theme = THEME_NORMAL
	return

func _set_is_selected(value : bool) -> void:
	is_selected = value
	if(is_selected):
		theme = THEME_SELECTED
	else:
		theme = THEME_NORMAL
	return

func build(level_data : LevelData) -> void:
	container_grid_modifier.build_grid(level_data.grid_modifier)
	for index_objective : int in range(LevelData.NUM_OBJECTIVES):
		var container_objective : ContainerObjective = CONTAINER_OBJECTIVE.instantiate()
		vbox_container_objectives.add_child(container_objective)
		container_objective.update(level_data.objectives[index_objective])
	return


func _on_mouse_entered() -> void:
	is_hovered = true
	return


func _on_mouse_exited() -> void:
	is_hovered = false
	return
