class_name CommandSort
extends Command

var active_request: SortRequest

func _init(active_request: SortRequest) -> void:
	self.active_request = active_request

static func usage() -> String:
	return """sort - Sort files by file extension to a directory
		 Usage: sort [file-extension] [directory]
	"""

func exec_cmd(args: Array[String]) -> CommandOutput:
	if len(args) <= 1:
		return CommandOutput.new(1, "Not enough arguments\n")
	
	var extension := args[0]
	var directory := args[1]
	
	if extension == ".png":
		active_request.images_sorted = directory == "/pictures"
	elif extension == ".pdf":
		active_request.documents_sorted = directory == "/documents"
	elif extension == ".mp4":
		active_request.videos_sorted = directory == "/videos"
	else:
		return CommandOutput.new(2, "Permission denied\n")
	
	return CommandOutput.new(0, "Sorted %s files to %s\n" % [extension, directory])
