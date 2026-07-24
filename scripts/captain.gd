extends Area2D

@onready var label = $Label
@onready var dialogue_ui = get_node("/root/Main/DialogueUI")

var player_near = false
var can_interact = true    #for dialogue system

func _ready():
	label.visible = false
	dialogue_ui.dialogue_finished.connect(_on_dialogue_finished)

func _on_body_entered(body):
	if body.name == "Player":
		player_near = true
		label.visible = true


func _on_body_exited(body):
	if body.name == "Player":
		player_near = false
		label.visible = false
		


func _process(_delta):
	if player_near and can_interact and Input.is_action_just_pressed("interact") and !dialogue_ui.dialogue_open:
		can_interact = false
		dialogue_ui.show_dialogue(
			"Captain",
			[
				"Engineer...",
				"The reactor is unstable.",
				"We need replacement parts.",
				"Go to the Storage Room.",
				"Return to me once you've collected them."
			]
		)
	
func _on_dialogue_finished():
	await get_tree().create_timer(0.2).timeout
	can_interact = true
