class_name DesktopWindow
extends Control

@onready var close_btn: TextureButton = $VBoxContainer/WindowTitleBar/MarginContainer/CloseButton
@onready var title: Label = $VBoxContainer/WindowTitleBar/MarginContainer/Label
@onready var window_title_bar: PanelContainer = $VBoxContainer/WindowTitleBar

@export var title_text: String = "Title"

var is_hovering_title_bar: bool = false
var is_dragging: bool = false
var previous_mouse_pos: Vector2
var mouse_offset: Vector2

signal window_closed

func _ready() -> void:
	title.text = title_text
	close_btn.pressed.connect(close_window)
	
	window_title_bar.mouse_entered.connect(func(): is_hovering_title_bar = true)
	window_title_bar.mouse_exited.connect(func(): is_hovering_title_bar = false)
	
	var viewport_size := get_viewport_rect().size
	
	size = Vector2(viewport_size.x * 0.3, viewport_size.y * 0.5)
	
	position = Vector2(
		viewport_size.x/2 - size.x/2, 
		viewport_size.y/2 - size.y/2
	)
	
	set_offsets_preset(PRESET_CENTER, PRESET_MODE_KEEP_SIZE)
	open_window()

func _process(_delta: float) -> void:
	if is_dragging:
		if previous_mouse_pos != Vector2.ZERO:
			mouse_offset = get_global_mouse_position() - previous_mouse_pos
		previous_mouse_pos = get_global_mouse_position()
		global_position += mouse_offset

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed and is_hovering_title_bar:
			is_dragging = true
		else:
			previous_mouse_pos = Vector2.ZERO
			is_dragging = false

func open_window() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.15).from(Vector2(0, 0)).set_ease(Tween.EASE_OUT)
	
	await tween.finished

func close_window() -> void:
	var tween := create_tween()
	tween.tween_property(self, "scale", Vector2(0, 0), 0.15).set_ease(Tween.EASE_OUT)
	
	await tween.finished
	window_closed.emit()
	
	queue_free()
