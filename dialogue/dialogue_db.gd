class_name DialogueDB
extends Node

var dialogue_db: Dictionary[String, String] = {
	"intro": "* Alright, let's see what they want today."
}

func get_dialogue(key: String) -> String:
	return dialogue_db[key]
