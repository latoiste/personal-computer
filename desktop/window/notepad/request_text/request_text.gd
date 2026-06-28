class_name RequestText
extends VBoxContainer

var request: Request

@onready var request_title: Label = $HSplitContainer/Title
@onready var description: Label = $Description
@onready var address: Label = $Address
@onready var reward: Label = $Reward
@onready var timer: Label = $HSplitContainer/Timer

func _ready() -> void:
	request_title.text = request.request_title
	description.text = request.description
	address.text = "Client PC location: %s" % request.id
	reward.text = "Reward: %s" % str(request.reward)
	
	request.timeout.connect(queue_free, CONNECT_ONE_SHOT)

func _process(_delta: float) -> void:
	update_timer_text()

func initialize(request: Request) -> void:
	self.request = request

func update_timer_text() -> void:
	var minutes := int(request.remaining_time / 60)
	var seconds := int(request.remaining_time) % 60
	
	timer.text = "%02d:%02d" % [minutes, seconds]
	
