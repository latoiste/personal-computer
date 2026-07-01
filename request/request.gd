@abstract
class_name Request
extends Node

var id: String
var request_title: String
var description: String
var reward: int
var duration_sec: int
var remaining_time: float:
	set(value):
		remaining_time = value
		if (value <= 0):
			timeout.emit()
var allowed_commands: Array[String]

var is_accepted: bool

signal completed
signal activated
signal timeout

@abstract func todo() -> String
@abstract func check_win() -> bool
@abstract func clone() -> Request

func _init(request_title: String, description: String, reward: int, duration_sec: int, allowed_commands: Array[String]) -> void:
	self.request_title = request_title
	self.description = description
	self.reward = reward
	self.duration_sec = duration_sec
	self.allowed_commands = allowed_commands
	
	id = _random_id()
	#id = "1"
	is_accepted = false
	remaining_time = duration_sec

func activate() -> void:
	activated.emit()

func complete() -> bool:
	if check_win():
		completed.emit()
		return true
	return false

func on_accepted() -> void:
	is_accepted = true

func _random_id() -> String:
	var first := randi_range(128, 191)
	var second := randi_range(0, 255)
	var third := randi_range(0, 255)
	var fourth := randi_range(0, 255)
	
	return "%d.%d.%d.%d" % [first, second, third, fourth]
