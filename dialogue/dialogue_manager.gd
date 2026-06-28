# extends Node

# var intro_passed: bool
# var task_opened: bool
# var terminal_opened: bool

# signal render_dialogue(text: String)

# func on_intro():
# 	if !intro_passed:
# 		intro_passed = true
# 		render_dialogue.emit(DialogueDb.get_dialogue("intro"))

# func on_task_opened():
# 	if !task_opened:
# 		task_opened = true
# 		render_dialogue.emit(DialogueDb.get_dialogue("task_open_01"))

# func on_terminal_opened():
# 	if !terminal_opened:
# 		terminal_opened = true
# 		render_dialogue.emit(DialogueDb.get_dialogue("terminal_open_01"))
