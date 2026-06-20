class_name Screen
extends Control

@onready var taskbar: Taskbar = $Taskbar

signal window_opened(window: DesktopWindow)
signal window_closed(window: DesktopWindow)

func _ready() -> void:
	taskbar.open_window.connect(try_open_window)

func try_open_window(scene: PackedScene) -> void:
	var instance := scene.instantiate()
	var window_class = instance.get_script()

	if instance is not DesktopWindow:
		return
	
	for child in get_children():
		if window_class == child.get_script():
			instance.queue_free()
			return
	
	add_child(instance)
	var desktop_window := instance as DesktopWindow
	desktop_window.window_closed.connect(func(): window_closed.emit(desktop_window), CONNECT_ONE_SHOT)
	
	window_opened.emit(instance)
