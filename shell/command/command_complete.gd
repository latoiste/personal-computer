class_name CommandComplete
extends Command

var active_request: SortRequest

func _init(active_request: SortRequest) -> void:
	self.active_request = active_request

static func usage() -> String:
	return """complete - Finish a request
		 Usage: complete
	"""

func exec_cmd(_args: Array[String]) -> CommandOutput:
	var success := active_request.complete()
	if !success:
		return CommandOutput.new(1, "Request not completed, check 'todo' for remaining tasks\n")
	
	return CommandOutput.new(0, "Request completed, tunneling out of %s\n" % active_request.id)
