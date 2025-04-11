extends CanvasLayer

@onready var log_label: Label = $Amount/LogLabel
@onready var egg_label: Label = $Amount/EggLabel
@onready var rice_label: Label = $Amount/RiceLabel
@onready var tomato_label: Label = $Amount/TomatoLabel


func _ready() -> void:
	log_label.text = "Log:" + str(InventoryManager.inventory.get("log", 0))
	egg_label.text = "Egg:" + str(InventoryManager.inventory.get("egg", 0))
	rice_label.text = "Rice:" + str(InventoryManager.inventory.get("rice", 0))
	tomato_label.text = "Tomato:" + str(InventoryManager.inventory.get("tomato", 0))

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/ui/menu_screen.tscn")


func _on_continue_button_pressed() -> void:
	DayCycleManager.set_process(true)
	queue_free()
