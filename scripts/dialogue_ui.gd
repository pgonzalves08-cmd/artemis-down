extends CanvasLayer

signal dialogue_finished

var conversation_finished = false
var dialogue_open := false
@onready var panel = $Panel
@onready var name_label = $Panel/NameLabel
@onready var dialogue_label = $Panel/DialogueLabel
@onready var continue_label = $Panel/ContinueLabel

var dialogue_lines: Array = []
var current_line := 0

var full_text := ""
var visible_characters := 0
var typing := false

func _ready():
	panel.hide()
	
func show_dialogue(character_name: String, lines: Array):
	panel.show()
	dialogue_open = true
	
	var player = get_tree().current_scene.get_node("Player")
	player.can_move = false
	
	name_label.text = character_name

	dialogue_lines = lines
	current_line = 0

	show_current_line()

func show_current_line():
	full_text = dialogue_lines[current_line]

	visible_characters = 0
	dialogue_label.text = ""

	typing = true
	$TypeTimer.start()
	
	
func hide_dialogue():
	panel.hide()
	dialogue_open = false
	typing = false

	dialogue_lines.clear()
	current_line = 0
	
	var player = get_tree().current_scene.get_node("Player")
	player.can_move = true

	$TypeTimer.stop()
	dialogue_finished.emit()

func _on_type_timer_timeout():
	if visible_characters < full_text.length():
		visible_characters += 1
		dialogue_label.text = full_text.substr(0, visible_characters)
	else:
		typing = false
		$TypeTimer.stop()

func _input(event):
	if dialogue_open and event.is_action_pressed("interact"):

		if typing:
			typing = false
			$TypeTimer.stop()
			dialogue_label.text = full_text

		else:
			current_line += 1

			if current_line < dialogue_lines.size():
				show_current_line()
			else:
				hide_dialogue()
