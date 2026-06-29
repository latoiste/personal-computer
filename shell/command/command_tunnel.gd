class_name CommandTunnel
extends Command

var accepted_request: Array[Request]

func _init(accepted_request: Array[Request]) -> void:
	self.accepted_request = accepted_request

static func usage() -> String:
	return """tunnel - Tunnel to a client PC
		 Usage: tunnel [location]
	"""

func exec_cmd(args: Array[String]) -> Command.CommandOutput:
	if len(args) <= 0:
		return CommandOutput.new(2, "Location not given\n")
	
	var location := args[0]
	for request in accepted_request:
		if request.id == location:
			request.activate()
			return CommandOutput.new(0, "Tunneling into %s\nStarted '%s'\n" % [location, request.request_title])
	
	return CommandOutput.new(1, "Could not find location\n")
