extends CharacterBody2D

@onready var interactable_component: InteractableComponent = $InteractableComponent
@onready var interactable_label_component: Control = $InteractableLabelComponent
@onready var timer: Timer = $Timer

var dialogue_scene = preload("res://dialogue/game_dialogue.tscn")
var in_range: bool
var is_walking = false
var walk_speed = 40.0
var walk_direction = Vector2.DOWN


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)
	interactable_component.interactable_deactivated.connect(on_interactable_deactivated)
	timer.timeout.connect(_on_timer_timeout)
	interactable_label_component.hide()


func _on_timer_timeout():
	if not is_walking:
		is_walking = true
		timer.start(10.0)
	else:
		is_walking = false
		velocity = Vector2.ZERO


func on_interactable_activated() -> void:
	interactable_label_component.show()
	in_range = true
	

func on_interactable_deactivated() -> void:
	interactable_label_component.hide()
	in_range = false


func _unhandled_input(event: InputEvent) -> void:
	if in_range:
		if event.is_action_pressed("show_dialogue"):
			var dialogue: BaseGameDialogue = dialogue_scene.instantiate()
			get_tree().current_scene.add_child(dialogue)
			dialogue.start(load("res://dialogue/conversation/owner.dialogue"), "start")
			dialogue.dialogue_finished.connect(_on_dialogue_finished)


func _on_dialogue_finished():
	timer.start(5.0) # delay 5 detik
	
	
func _physics_process(_delta: float) -> void:
	if is_walking:
		velocity = walk_direction * walk_speed
		move_and_slide()
