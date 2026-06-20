class_name Dialogue
extends Control

@onready var label: Label = $MarginContainer/Label

const TEXT_SPEED = 0.02

func _ready() -> void:
	visible = false

func render(text: String) -> void:
	visible = true
	label.visible = false
	scale.y = 0
	
	var tween := create_tween()
	tween.tween_property(self, "scale:y", 1, 0.1)
	
	await tween.finished
	
	label.text = text
	label.visible = true
	label.visible_ratio = 0
	await animate_text()
	await get_tree().create_timer(1.5).timeout
	
	close()
	visible = false

func close() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale:y", 0, 0.1)
	
func animate_text() -> void:
	var tween := create_tween()
	
	var duration := TEXT_SPEED * len(label.text)
	tween.tween_property(label, "visible_ratio", 1, duration).from(0)
	
	await tween.finished
