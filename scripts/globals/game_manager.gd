extends Node


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("back_menu"):
		get_tree().change_scene_to_file("res://scenes/ui/menu_screen.tscn")


func start_game() -> void:
	pass


func exit_grame() -> void:
	get_tree().quit()
