extends Node
class_name Test

const GRID_MODIFIER_CRAZY_EIGHTS : GridModifier = preload("res://data/modifier/level/grid/grid_modifiers/grid_modifier_crazy_eights.tres")
const GRID_MODIFIER_GONE_FISHING : GridModifier = preload("res://data/modifier/level/grid/grid_modifiers/grid_modifier_gone_fishing.tres")
const GRID_MODIFIER_STANDARD : GridModifier = preload("res://data/modifier/level/grid/grid_modifiers/grid_modifier_standard.tres")
const GRID_MODIFIER_TWO_TOWERS : GridModifier = preload("res://data/modifier/level/grid/grid_modifiers/grid_modifier_two_towers.tres")

func _ready() -> void:
	#ObjectiveFactory.build()
	#GridModifierFactory.build("standard")
	#GridModifierFactory.build("crazy_eights")
	#GridModifierFactory.build("two_towers")
	#GridModifierFactory.build("gone_fishing")
	#print("crazy_eights")
	#print(GRID_MODIFIER_CRAZY_EIGHTS._to_string())
	#print("two_towers")
	#print(GRID_MODIFIER_TWO_TOWERS._to_string())
	#print("gone_fishing")
	#print(GRID_MODIFIER_GONE_FISHING._to_string())
	var level_data : LevelData = LevelBuilder.build(LevelData.Difficulty.MEDIUM)
	print(level_data._to_string())
	return
