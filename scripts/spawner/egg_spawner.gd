extends Area2D

@export var egg_scene: PackedScene = preload("res://scenes/objects/lifestocks/egg.tscn")
@onready var timer: Timer = $Timer
@onready var shape_rect: RectangleShape2D = $CollisionShape2D.shape
const MAX_EGGS := 5

func _ready():
	timer.wait_time = 30.0
	timer.autostart = true
	timer.one_shot = false
	timer.timeout.connect(spawn_random_egg)
	timer.start()

func spawn_random_egg():
	var eggs = get_tree().get_nodes_in_group("eggs")
	if eggs.size() >= MAX_EGGS:
		#print("Sudah ada ", eggs.size(), " telur. Tidak spawn baru.")
		return

	# posisi random dalam CollisionShape
	var rect_size = shape_rect.extents * 2
	var offset = Vector2(
		randf_range(0, rect_size.x),
		randf_range(0, rect_size.y)
	)
	var local_pos = offset - shape_rect.extents
	var global_spawn_pos = to_global(local_pos)

	# Spawn telur
	var egg = egg_scene.instantiate()
	egg.global_position = global_spawn_pos
	get_tree().current_scene.add_child(egg)
	egg.add_to_group("eggs")
	#print("Spawned egg at:", global_spawn_pos)
