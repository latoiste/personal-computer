class_name DialogueDB
extends Node

var dialogue_db: Dictionary[String, String] = {
	"intro": "* Alright, let's see what he wants today.",
	"task_open_01": "* Oh. That's it? I mean, alright I guess I have nothing to complain about.",
	"terminal_open_01": "* OK. Let's just get this done.",
	"restore_attempt_01": "* Of course it's not that easy."
}

func get_dialogue(key: String) -> String:
	return dialogue_db[key]
