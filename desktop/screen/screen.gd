extends Control

@onready var taskbar: Taskbar = $Taskbar

func _ready() -> void:
	taskbar.open_window.connect(try_open_window)

func try_open_window(scene: PackedScene) -> void:
	var instance := scene.instantiate()
	var window_class = instance.get_script()

	for child in get_children():
		if window_class == child.get_script():
			instance.queue_free()
			return
			
	add_child(instance)
