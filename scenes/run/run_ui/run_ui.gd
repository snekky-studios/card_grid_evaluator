extends Control
class_name RunUI

signal level_data_selected(index_level_data : int)

var panel_level_data : Array[PanelLevelData] = []

var panel_level_data_0 : PanelLevelData = null
var panel_level_data_1 : PanelLevelData = null
var panel_level_data_2 : PanelLevelData = null

func _ready() -> void:
	panel_level_data.append(%PanelLevelData0)
	panel_level_data.append(%PanelLevelData1)
	panel_level_data.append(%PanelLevelData2)
	return


func _on_button_confirm_pressed() -> void:
	
	return
