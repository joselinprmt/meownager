class_name FieldCursorComponent
extends Node

@export var grass_tilemap_layer: TileMapLayer
@export var tilled_soil_tilemap_layer: TileMapLayer
@export var terrain_set: int = 0
@export var terrain: int = 2
@export var water: int = 4

@onready var player: Player = get_tree().get_first_node_in_group("player")

var mouse_position: Vector2
var cell_position: Vector2i
var cell_source_id: int
var local_cell_position: Vector2
var distance: float
var terrain_map := {}


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("remove_field"):
		if ToolManager.selected_tool == DataTypes.Tools.TillGrounds:
			get_cell_under_mouse()
			remove_tilled_soil_cell()
			
	elif event.is_action_pressed("hit"):
		if ToolManager.selected_tool == DataTypes.Tools.TillGrounds:
			get_cell_under_mouse()
			add_tilled_soil_cell()
			
		elif ToolManager.selected_tool == DataTypes.Tools.WaterCrops:
			get_cell_under_mouse()
			water_soil_cell()


func get_cell_under_mouse() -> void:
	mouse_position = grass_tilemap_layer.get_local_mouse_position()
	cell_position = grass_tilemap_layer.local_to_map(mouse_position)
	cell_source_id = grass_tilemap_layer.get_cell_source_id(cell_position)
	local_cell_position = grass_tilemap_layer.map_to_local(cell_position)
	distance = player.global_position.distance_squared_to(local_cell_position)
	#print("mouse_position: ", mouse_position, ", cell_position: ", cell_position, ", cell_source_id: ", cell_source_id)
	#print("distance: ", distance)
	

func add_tilled_soil_cell() -> void:
	# jarak mouse dengan player tidak lebih dari 400
	# cell source id bukan -1 jika mouse klik pada area grass
	if distance < (20 * 20) && cell_source_id != -1:
		# cek dulu, kalau posisi itu sudah water, tidak usah ubah
		if terrain_map.get(cell_position, -1) == water:
			return # sudah water, skip perubahan
		# kalau bukan water, set jadi tilled soil (soil kering)
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], terrain_set, terrain, true)
		terrain_map[cell_position] = terrain


func remove_tilled_soil_cell() -> void:
	if distance < (20 * 20):
		tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], 0, -1, true)
		terrain_map.erase(cell_position)


func water_soil_cell() -> void:
	if distance < (20 * 20):
		if terrain_map.get(cell_position, -1) == terrain:
			tilled_soil_tilemap_layer.set_cells_terrain_connect([cell_position], terrain_set, water, true)
			terrain_map[cell_position] = water
