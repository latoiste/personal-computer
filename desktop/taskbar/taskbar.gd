class_name Taskbar
extends HBoxContainer

signal open_window(scene: PackedScene)

func _ready() -> void:
	for child in get_children():
		if child is TaskbarIcon:
			child.pressed.connect(
				func(): open_window.emit(child.WINDOW_SCENE)
			)
