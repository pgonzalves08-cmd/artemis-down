extends Area2D

@onready var label = $Label
@onready var dialogue_ui = get_node("/root/Main/UI/DialogueUI")

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
		
		match QuestManager.quest_stage:
			0:
				QuestManager.current_quest = "Collect replacement parts"
				QuestManager.quest_stage = 1

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

			1:
				dialogue_ui.show_dialogue(
					"Captain",
					[
						"Why are you still here?",
						"The replacement parts are in the Storage Room.",
						"Hurry, the reactor won't last forever!"
					]
				)

			2:
				QuestManager.quest_stage = 3

				dialogue_ui.show_dialogue(
					"Captain",
					[
						"Excellent work!",
						"You found the replacement parts.",
						"Let's get the reactor running again."
					]
				)

			3:
				dialogue_ui.show_dialogue(
					"Captain",
					[
						"The reactor is stable now.",
						"Thank you, Engineer."
					]
				)

func _on_dialogue_finished():
	await get_tree().create_timer(0.2).timeout
	can_interact = true
