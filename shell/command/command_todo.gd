class_name CommandTodo
extends Command

var active_request: Request

func _init(active_request: Request) -> void:
	self.active_request = active_request

static func usage() -> String:
	return """todo - Prints a to-do list for a request
		 Usage: todo
	"""

func exec_cmd(_args: Array[String]) -> CommandOutput:
	if active_request:
		return CommandOutput.new(0, active_request.todo())
	else:
		return CommandOutput.new(1, "No active requests\n")
