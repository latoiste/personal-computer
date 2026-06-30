class_name SortRequest
extends Request

@onready var images_sorted: bool = false
@onready var documents_sorted: bool = false
@onready var videos_sorted: bool = false

func todo() -> String:
	var output := ""
	output += "%s Sort images (.png) to /pictures\n" % ["☐" if !images_sorted else "☒"]
	output += "%s Sort documents (.pdf) to /documents\n" % ["☐" if !documents_sorted else "☒"]
	output += "%s Sort videos (.mp4) to /videos\n" % ["☐" if !videos_sorted else "☒"]
	
	return output

func clone() -> SortRequest:
	var copy := SortRequest.new(request_title, description, reward, duration_sec, allowed_commands)
	return copy

func check_win() -> bool:
	if images_sorted && documents_sorted && videos_sorted:
		return true
	return true
