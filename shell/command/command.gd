class_name Command
extends Node

static func usage() -> String:
	return ""

func exec_cmd(args: Array[String]) -> CommandOutput:
	return null

class CommandOutput:
	var error_code: int
	var output: String
	
	func _init(error_code: int = -1, output: String = "") -> void:
		self.error_code = error_code
		self.output = output
