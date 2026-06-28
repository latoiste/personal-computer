class_name Notepad
extends DesktopWindow

@onready var content: VBoxContainer = $VBoxContainer/PanelContainer/ScrollContainer/MarginContainer/Content

const REQUEST_TEXT_SCENE = preload("uid://b376lh2npwgjx")

var request_manager: RequestManager

func _ready() -> void:
	super._ready()
	request_manager.request_added.connect(add_request)
	
	for request in request_manager.accepted_requests:
		write_request(request)

func initialize(request_manager: RequestManager) -> void:
	self.request_manager = request_manager
	print(self.request_manager)

func add_request(request: Request) -> void:
	write_request(request)

func write_request(request: Request) -> void:
	var instance := REQUEST_TEXT_SCENE.instantiate() as RequestText
	instance.initialize(request)
	
	content.add_child(instance)

func remove_request() -> void:
	pass
