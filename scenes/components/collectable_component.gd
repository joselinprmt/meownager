class_name CollectableComponent
extends Area2D

@export var collectable_name: String

@onready var sfx_collect: AudioStreamPlayer2D = $sfxCollect


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		sfx_collect.play()
		InventoryManager.add_collectable(collectable_name)
		await get_tree().create_timer(0.15).timeout
		get_parent().queue_free()
