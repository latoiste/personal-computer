class_name Notepad
extends DesktopWindow

@onready var content: VBoxContainer = $VBoxContainer/PanelContainer/ScrollContainer/MarginContainer/Content
@onready var placeholder: Label = $VBoxContainer/PanelContainer/ScrollContainer/MarginContainer/CenterContainer/Placeholder

const REQUEST_TEXT_SCENE = preload("uid://b376lh2npwgjx")

var request_manager: RequestManager

func _ready() -> void:
	super._ready()
	request_manager.request_added.connect(request_added)
	request_manager.request_removed.connect(request_removed)
	
	placeholder.visible = request_manager.accepted_requests.is_empty()
	
	for request in request_manager.accepted_requests:
		write_request(request)

func initialize(request_manager: RequestManager) -> void:
	self.request_manager = request_manager

func request_added(request: Request) -> void:
	placeholder.visible = false
	write_request(request)

func request_removed(_request: Request) -> void:
	if request_manager.accepted_requests.is_empty():
		placeholder.visible = true

func write_request(request: Request) -> void:
	var instance := REQUEST_TEXT_SCENE.instantiate() as RequestText
	instance.initialize(request)
	
	content.add_child(instance)
