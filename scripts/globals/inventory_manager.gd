extends Node


var inventory: Dictionary = Dictionary()

signal inventory_changed


func add_collectable(collectable_name: String) -> void:
	inventory.get_or_add(collectable_name)
	
	# init (key: name, value: 1) jika belum ada di dict, else += 1
	if (inventory[collectable_name] == null):
		inventory[collectable_name] = 1
	else:
		inventory[collectable_name] += 1
	
	inventory_changed.emit()
