class_name GrowthCycleComponent
extends Node

@export var current_growth_state: DataTypes.GrowthStates = DataTypes.GrowthStates.Seed
@export_range(5, 365) var days_until_harvest = 5

signal crop_maturity
signal crop_harvesting

var is_watered: bool
var start_day: int
var current_day: int


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DayCycleManager.time_tick_day.connect(on_time_tick_day)
	

func on_time_tick_day(day: int) -> void:
	if is_watered:
		if start_day == 0:
			start_day = day
	
		growth_states(start_day, day)
		harvest_state(start_day, day)


func growth_states(start_day: int, current_day: int):
	if current_growth_state == DataTypes.GrowthStates.Maturity:
		return
	
	var num_states = 5
	var growth_days_passed = (current_day - start_day) % num_states
	var state_index = growth_days_passed % num_states + 1
	
	current_growth_state = state_index
	
	var state_name = DataTypes.GrowthStates.keys()[current_growth_state]
	#print("Current groth state: ", state_name, ", State index: ", state_index)
	
	if current_growth_state == DataTypes.GrowthStates.Maturity:
		crop_maturity.emit()


func harvest_state(start_day: int, current_day: int) -> void:
	if current_growth_state == DataTypes.GrowthStates.Harvesting:
		return
	
	var day_passed = (current_day - start_day) % days_until_harvest
	
	if day_passed == days_until_harvest - 1:
		current_growth_state = DataTypes.GrowthStates.Harvesting
		crop_harvesting.emit()


func get_current_growth_state() -> DataTypes.GrowthStates:
	return current_growth_state
	
