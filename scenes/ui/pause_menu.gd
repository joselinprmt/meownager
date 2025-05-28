extends CanvasLayer

@onready var continue_button: Button = $Panel/VBoxContainer/MarginContainer/VBoxContainer/ContinueButton
@onready var exit_button: Button = $Panel/VBoxContainer/MarginContainer/VBoxContainer/ExitButton

func _ready():
	visible = false
	get_tree().paused = false

func toggle_pause_menu():
	visible = !visible
	get_tree().paused = visible
	
	get_viewport().set_input_as_handled()

func _on_continue_pressed():
	print("Continue pressed")
	toggle_pause_menu()

func _on_exit_pressed():
	get_tree().paused = false
	print("Exit")
	call_deferred("go_home")
	
func go_home():
	get_tree().change_scene_to_file(str("res://scenes/ui/menu_screen.tscn"))
