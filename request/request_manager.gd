class_name RequestManager
extends Node

var active_request: Request
var accepted_requests: Array[Request]

signal request_added(request: Request)
signal request_removed(request: Request)
signal request_completed(request: Request)

func on_new_request(request: Request) -> void:
	request.timeout.connect(on_request_timeout.bind(request))

func on_request_accepted(request: Request) -> void:
	accepted_requests.append(request)
	
	request.activated.connect(on_request_activated.bind(request))
	request.completed.connect(on_request_completed.bind(request))
	request.timeout.connect(on_request_timeout.bind(request))
	request_added.emit(request)

func on_request_activated(request: Request) -> void:
	active_request = request

func on_request_completed(request: Request) -> void:
	active_request = null
	
	accepted_requests.erase(request)
	request_completed.emit(request)
	request_removed.emit(request)

func on_request_timeout(request: Request) -> void:
	active_request = null
	accepted_requests.erase(request)
	request_removed.emit(request)

func _process(delta: float) -> void:
	for request in accepted_requests:
		if request.is_accepted:
			request.remaining_time -= delta
