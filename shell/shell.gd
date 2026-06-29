class_name Shell
extends Node

var request_manager: RequestManager

var default_commands: Array[String] = ["help", "tunnel", "todo"]

func initialize(request_manager: RequestManager) -> void:
	self.request_manager = request_manager

func parse_command(command: String) -> String:
	var split := command.split(" ")
	var bin := split[0]
	var args := split.slice(1)
	var allowed_commands: Array[String]
	
	if request_manager.active_request:
		allowed_commands = request_manager.active_request.allowed_commands
	else:
		allowed_commands = default_commands
	
	if !allowed_commands.has(bin):
		return "Unknown command. Type 'help' for list of available commands\n"
	
	match bin:
		"help":
			var help: CommandHelp
			if request_manager.active_request:
				help = CommandHelp.new(request_manager.active_request.allowed_commands)
			else:
				help = CommandHelp.new(default_commands)
			var output := help.exec_cmd(args)
			
			return output.output
		"tunnel":
			var tunnel := CommandTunnel.new(request_manager.accepted_requests)
			var output := tunnel.exec_cmd(args)
			
			return output.output
		"todo":
			var todo := CommandTodo.new(request_manager.active_request)
			var output := todo.exec_cmd(args)
			
			return output.output
		"sort":
			var sort := CommandSort.new(request_manager.active_request)
			var output := sort.exec_cmd(args)
			
			return output.output
		"complete":
			var complete := CommandComplete.new(request_manager.active_request)
			var output := complete.exec_cmd(args)
			
			return output.output
	return "Unknown command. Type 'help' for list of available commands\n"
