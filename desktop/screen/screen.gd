class_name Screen
extends Control

@onready var taskbar: Taskbar = $Taskbar
@onready var notif: NotificationWidget = $Notification

const TERMINAL_SCENE := preload("uid://cy5dik8x2m1ht")
const NOTEPAD_SCENE := preload("uid://ceyu1qra6du6a")

signal window_opened(window: DesktopWindow)
signal window_closed(window: DesktopWindow)

var request_manager: RequestManager

func _ready() -> void:
	notif.visible = false
	
	taskbar.terminal_icon_pressed.connect(try_open_window.bind("terminal"))
	taskbar.notepad_icon_pressed.connect(try_open_window.bind("notepad"))
	taskbar.notification_icon_pressed.connect(toggle_notification)

func on_new_request(request: Request) -> void:
	notif.new_notification(request)
	if !notif.visible:
		taskbar.notif_icon_unread()

func toggle_notification() -> void:
	notif.visible = !notif.visible
	if notif.visible:
		taskbar.notif_icon_read()

func try_open_window(window: String) -> void:
	var instance := create_window(window)
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

func create_window(window: String) -> Node:
	match window:
		"terminal":
			var instance := TERMINAL_SCENE.instantiate() as Terminal
			instance.initialize(request_manager)
			return instance
		"notepad":
			var instance := NOTEPAD_SCENE.instantiate() as Notepad
			instance.initialize(request_manager)
			return instance
	return null
