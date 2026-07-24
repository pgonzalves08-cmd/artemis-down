extends Area2D

@onready var label = $Label2

var player_near = false

func _ready():
	label.visible = false

func _on_body_entered(body):
	if body.name == "Player":
		player_near = true
		label.visible = true

func _on_body_exited(body):
	if body.name == "Player":
		player_near = false
		label.visible = false

func _process(_delta):
	if player_near and QuestManager.quest_stage == 1 and Input.is_action_just_pressed("interact"):
		QuestManager.quest_stage = 2
		label.visible = false
		queue_free()
