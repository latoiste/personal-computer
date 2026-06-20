class_name Terminal
extends DesktopWindow

@onready var shell = $Shell
@onready var terminal_body: Panel = %TerminalBody
@onready var prompt_container: VBoxContainer = %PromptContainer
@onready var prompt: Prompt = %Prompt

const TERMINAL_OUTPUT_SCENE := preload("uid://hyomnxmgdibe")

func _ready() -> void:
	super._ready()
	prompt.text_submitted.connect(on_submit)

func on_submit(text: String) -> void:
	var shell_output := "FAKE SHELL OUTPUT AAAAAAAAAAAAAAAAAAA"
	var output_string := "> %s\n%s\n" % [text, shell_output]
	var output := TERMINAL_OUTPUT_SCENE.instantiate()
	output.text = output_string
	
	var child_count := prompt_container.get_child_count()
	
	prompt_container.add_child(output)
	prompt_container.move_child(output, child_count - 1)
	
	var scrollbar: VScrollBar = $VBoxContainer/PanelContainer/ScrollContainer.get_v_scroll_bar()
	await get_tree().process_frame
	scrollbar.value = scrollbar.max_value * 2
