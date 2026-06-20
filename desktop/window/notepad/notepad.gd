class_name Notepad
extends DesktopWindow

@export var content_text: String

@onready var content: Label = $VBoxContainer/PanelContainer/MarginContainer/Content

func _ready() -> void:
	super._ready()
	content.text = content_text
