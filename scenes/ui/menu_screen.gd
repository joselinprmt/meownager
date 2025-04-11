extends CanvasLayer

@export var scene_to_load: String = "main_scene"


func _on_start_game_button_pressed() -> void:
	get_tree().change_scene_to_file(str("res://scenes/main/" + scene_to_load + ".tscn"))


func _on_control_button_pressed() -> void:
	get_tree().change_scene_to_file(str("res://scenes/ui/control_key_panel.tscn"))


func _on_exit_button_pressed() -> void:
	GameManager.exit_grame()
