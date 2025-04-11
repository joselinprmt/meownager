extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D


func _on_process(_delta: float) -> void:
	pass


func _on_physics_process(_delta: float) -> void:
	if player.player_direction == Vector2.UP:
		animated_sprite_2d.play("idle_back")
	elif player.player_direction == Vector2.DOWN:
		animated_sprite_2d.play("idle_front")
	elif player.player_direction == Vector2.LEFT:
		animated_sprite_2d.play("idle_left")
	elif player.player_direction == Vector2.RIGHT:
		animated_sprite_2d.play("idle_right")
	else:
		animated_sprite_2d.play("idle_front")

func _on_next_transitions() -> void:
	GameInputEvents.movement_input()
	if GameInputEvents.is_movement_input():
		transition.emit("Walk")
		
	if GameInputEvents.is_using_tool() && player.current_tool == DataTypes.Tools.WaterCrops:
		transition.emit("Watering")
		
	if GameInputEvents.is_using_tool() && player.current_tool == DataTypes.Tools.AxeWoods:
		transition.emit("Chopping")
		
	if GameInputEvents.is_using_tool() && player.current_tool == DataTypes.Tools.TillGrounds:
		transition.emit("Tilling")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
