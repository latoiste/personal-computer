class_name Prompt
extends LineEdit

#const PREFIX := "> "

func _ready() -> void:
	#text_changed.connect(on_text_changed)
	#gui_input.connect(on_caret_moved)
	focus_entered.connect(on_focus)
	text_submitted.connect(on_submit)
	
	caret_blink = 0.5
	keep_editing_on_text_submit = true
	selecting_enabled = false
	add_theme_constant_override("caret_width", 8)

func on_focus() -> void:
	caret_column = len(text)

#func on_caret_moved(event: InputEvent) -> void:
	#if event is InputEventKey and event.keycode == KEY_LEFT:
		#if !event.pressed:
			#if caret_column < 2:
				#caret_column = 2

func on_submit(_text: String) -> void:
	text = ""
	#text = PREFIX
	#caret_column = 2

#func on_text_changed(new_text: String) -> void:
	#if len(new_text) < 2:
		#text = PREFIX
		#caret_column = 2
