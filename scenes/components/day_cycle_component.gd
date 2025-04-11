class_name DayCycleComponent
extends CanvasModulate

@export var initial_day: int = 1:
	set(init_day):
		initial_day = init_day
		DayCycleManager.initial_day = init_day
		DayCycleManager.set_initial_time()

@export var initial_hour: int = 10:
	set(init_hour):
		initial_hour = init_hour
		DayCycleManager.initial_hour = init_hour
		DayCycleManager.set_initial_time()

@export var initial_minute: int = 00:
	set(init_minute):
		initial_minute = init_minute
		DayCycleManager.initial_minute = init_minute
		DayCycleManager.set_initial_time()

@export var day_cycle_gradient_texture: GradientTexture1D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DayCycleManager.initial_day = initial_day
	DayCycleManager.initial_hour = initial_hour
	DayCycleManager.initial_minute = initial_minute
	DayCycleManager.set_initial_time()
	
	DayCycleManager.game_time.connect(on_game_time)


func on_game_time(time: float) -> void:
	var sampe_value = 0.5 * (sin(time - PI * 0.5) + 1.0)
	color = day_cycle_gradient_texture.gradient.sample(sampe_value)
