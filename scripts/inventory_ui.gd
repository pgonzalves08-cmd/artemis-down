extends CanvasLayer

@onready var label = $Panel/Label

func _ready():
	hide()

func _process(_delta):
	label.text = "Inventory\n\n"

	for item in Inventory.items:
		label.text += "• " + item + "\n"

func _input(event):
	if event.is_action_pressed("inventory"):
		if visible:
			hide()
		else:
			show()
