class_name CommandHelp
extends Command

var allowed_commands: Array[String]

func _init(allowed_commands: Array[String]) -> void:
	self.allowed_commands = allowed_commands

static func usage() -> String:
	return  """help - Print this message
		 Usage: help
	"""

func exec_cmd(_args: Array[String]) -> CommandOutput:
	var output := CommandOutput.new()
	
	for command in allowed_commands:
		match command:
			"help":
				output.output += CommandHelp.usage()
			"tunnel":
				output.output += CommandTunnel.usage()
			"todo":
				output.output += CommandTodo.usage()
			"sort":
				output.output += CommandSort.usage()
			"complete":
				output.output += CommandComplete.usage()
	return output
