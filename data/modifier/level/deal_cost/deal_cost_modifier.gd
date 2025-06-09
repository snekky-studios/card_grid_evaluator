extends Resource
class_name DealCostModifier

# how much deal costs at the start of each turn
@export var initial_cost : int = 0
# how much the cost increases each time the deal button is pressed
# deal cost resets each time the submit button is pressed
@export var cost_increase : int = 0

func _to_string() -> String:
	var output : String = ""
	output += "Initial Deal Cost: " + str(initial_cost) + "\n"
	output += "Cost Increase per Deal: " + str(cost_increase)
	return output
