class_name NotificationItem
extends NinePatchRect

@onready var request_title: Label = $MarginContainer/VBoxContainer/Title
@onready var description: Label = $MarginContainer/VBoxContainer/Description
@onready var reward: Label = $MarginContainer/VBoxContainer2/CenterContainer2/Reward
@onready var accept_button: TextureButton = $MarginContainer/VBoxContainer2/CenterContainer/HSplitContainer/AcceptButton
@onready var reject_button: TextureButton = $MarginContainer/VBoxContainer2/CenterContainer/HSplitContainer/RejectButton

var request: Request

signal request_accepted(request: Request)

func _ready() -> void:
	accept_button.pressed.connect(func(): 
		request.on_accepted()
		request_accepted.emit(request)
		queue_free()
	, CONNECT_ONE_SHOT)
	reject_button.pressed.connect(queue_free, CONNECT_ONE_SHOT)

func set_request(new_request: Request) -> void:
	request = new_request
	
	request_title.text = request.request_title
	description.text = new_request.description
	reward.text = "Reward: %s" % new_request.reward
