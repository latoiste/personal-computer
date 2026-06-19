class_name DesktopWindow
extends Control

@onready var close_btn: TextureButton = $VBoxContainer/WindowTitleBar/MarginContainer/CloseButton
@onready var title: Label = $VBoxContainer/WindowTitleBar/MarginContainer/Label
@onready var window_title_bar: PanelContainer = $VBoxContainer/WindowTitleBar

@export var title_text: String = "Title"

var is_hovering_title_bar: bool = false
var is_dragging: bool = false
var mouse_offset: Vector2

func _ready() -> void:
	title.text = title_text
	close_btn.pressed.connect(close_window)
	
	window_title_bar.mouse_entered.connect(func(): is_hovering_title_bar = true)
	window_title_bar.mouse_exited.connect(func(): is_hovering_title_bar = false)

#func _process(_delta: float) -> void:
	#if is_dragging:
		#global_position += mouse_offset

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and is_hovering_title_bar:
		if event.pressed:
			is_dragging = true
			mouse_offset = global_position - get_global_mouse_position()
			print(mouse_offset)
		else:
			is_dragging = false

func close_window() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2(0, 0), 0.1).set_ease(Tween.EASE_OUT)
	
	await tween.finished
	
	queue_free()
