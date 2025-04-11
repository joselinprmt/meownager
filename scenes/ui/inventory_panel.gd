extends PanelContainer

@onready var log_label: Label = $MarginContainer/VBoxContainer/Logs/LogLabel
@onready var egg_label: Label = $MarginContainer/VBoxContainer/Egg/EggLabel
@onready var rice_label: Label = $MarginContainer/VBoxContainer/Rice/RiceLabel
@onready var tomato_label: Label = $MarginContainer/VBoxContainer/Tomato/TomatoLabel


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	InventoryManager.inventory_changed.connect(on_inventory_changed)

func on_inventory_changed() -> void:
	var inventory: Dictionary = InventoryManager.inventory
	
	if (inventory.has("log")):
		log_label.text = str(inventory["log"])

	if (inventory.has("egg")):
		egg_label.text = str(inventory["egg"])

	if (inventory.has("rice")):
		rice_label.text = str(inventory["rice"])
		
	if (inventory.has("tomato")):
		tomato_label.text = str(inventory["tomato"])
