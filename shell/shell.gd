class_name Shell
extends Node

var request_manager: RequestManager

func initialize(request_manager: RequestManager) -> void:
	self.request_manager = request_manager

func parse_command(command: String) -> String:
	var split := command.split(" ")
	var bin := split[0]
	var args := split.slice(1)
	
	if request_manager.active_request:
		var allowed_commands := request_manager.active_request.allowed_commands
		if !allowed_commands.has(bin):
			return "Unknown command. Type 'help' for list of available commands"
	
	match bin:
		"help":
			var help: CommandHelp
			if request_manager.active_request:
				help = CommandHelp.new(request_manager.active_request.allowed_commands)
			else:
				help = CommandHelp.new(["help", "tunnel"])
			var output := help.exec_cmd(args)
			
			return output.output
		"tunnel":
			var tunnel := CommandTunnel.new(request_manager.accepted_requests)
			var output := tunnel.exec_cmd(args)
			
			return output.output
	return "Unknown command. Type 'help' for list of available commands"
