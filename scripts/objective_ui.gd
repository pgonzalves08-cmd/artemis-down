extends CanvasLayer

@onready var label = $Panel/Label

func _process(_delta):
	match QuestManager.quest_stage:
		0:
			label.text = "Objective:\nTalk to the Captain"
		1:
			label.text = "Objective:\nFind replacement parts  
			in the Storage Room"
		2:
			label.text = "Objective:\nReturn to the Captain"
		3:
			label.text = "Objective:\nMission Complete!"
