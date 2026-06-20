class_name Main
extends Control

@onready var dialogue: Dialogue = $Dialogue
@onready var screen: Screen = $Screen

func _ready() -> void:
	await get_tree().create_timer(0.5).timeout
	dialogue.render(DialogueDb.get_dialogue("intro"))
