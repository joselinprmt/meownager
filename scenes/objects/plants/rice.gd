extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var watering_particles: GPUParticles2D = $WateringParticles
@onready var ready_to_harvest_particles: GPUParticles2D = $ReadyToHarvestParticles
@onready var growth_cycle_component: GrowthCycleComponent = $GrowthCycleComponent
@onready var hurt_component: HurtComponent = $HurtComponent

var rice_harvest_scene = preload("res://scenes/objects/plants/rice_harvest.tscn")
var growth_state: DataTypes.GrowthStates = DataTypes.GrowthStates.Germination


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	watering_particles.emitting = false
	ready_to_harvest_particles.emitting = false
	
	hurt_component.hurt.connect(on_hurt)
	growth_cycle_component.crop_maturity.connect(on_crop_maturity)
	growth_cycle_component.crop_harvesting.connect(on_crop_harvesting)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	growth_state = growth_cycle_component.get_current_growth_state()
	sprite_2d.frame = growth_state
	
	if growth_state == DataTypes.GrowthStates.Maturity:
		ready_to_harvest_particles.emitting = true


func on_hurt(_hit_damage: int) -> void:
	if !growth_cycle_component.is_watered:
		watering_particles.emitting = true
		await get_tree().create_timer(5.0).timeout
		watering_particles.emitting = false
		growth_cycle_component.is_watered = true


func on_crop_maturity() -> void:
	ready_to_harvest_particles.emitting = true


func on_crop_harvesting() -> void:
	var rice_harvest_instance = rice_harvest_scene.instantiate() as Node2D
	rice_harvest_instance.global_position = global_position
	get_parent().add_child(rice_harvest_instance)
	queue_free()
