extends Control

@onready var day_label: Label = $DayPanel/MarginContainer/DayLabel
@onready var time_label: Label = $TimePanel/MarginContainer/TimeLabel

@export var normal_speed: int = 100


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	DayCycleManager.time_tick.connect(on_time_tick)


func on_time_tick(day: int, hour: int, minute: int) -> void:
	day_label.text = "Day " + str(day)
	if minute % 30 == 0:
		time_label.text = "%02d:%02d" % [hour, minute]
	DayCycleManager.game_speed = normal_speed
	
