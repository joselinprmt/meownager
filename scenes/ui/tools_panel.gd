extends PanelContainer


@onready var tool_watering: Button = $MarginContainer/HBoxContainer/ToolWatering
@onready var tool_axe: Button = $MarginContainer/HBoxContainer/ToolAxe
@onready var tool_tilling: Button = $MarginContainer/HBoxContainer/ToolTilling
@onready var seed_rice: Button = $MarginContainer/HBoxContainer/SeedRice
@onready var seed_tomato: Button = $MarginContainer/HBoxContainer/SeedTomato


func _on_tool_watering_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.WaterCrops)


func _on_tool_axe_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.AxeWoods)


func _on_tool_tilling_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.TillGrounds)


func _on_seed_rice_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.PlantRice)


func _on_seed_tomato_pressed() -> void:
	ToolManager.select_tool(DataTypes.Tools.PlantTomato)


# untuk unselect tools
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			ToolManager.select_tool(DataTypes.Tools.None)
			tool_watering.release_focus()
			tool_axe.release_focus()
			tool_tilling.release_focus()
			seed_rice.release_focus()
			seed_tomato.release_focus()
