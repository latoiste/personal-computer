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

var is_accepted: bool

signal on_complete
signal timeout

func _init(request_title: String, description: String, reward: int, duration_sec: int) -> void:
	self.request_title = request_title
	self.description = description
	self.reward = reward
	self.duration_sec = duration_sec
	
	id = _random_id()
	is_accepted = false
	remaining_time = duration_sec

func clone() -> Request:
	var copy := Request.new(request_title, description, reward, duration_sec)
	return copy

func on_accepted() -> void:
	print("hello im request and im accepted")
	is_accepted = true

func _random_id() -> String:
	var first := randi_range(128, 191)
	var second := randi_range(0, 255)
	var third := randi_range(0, 255)
	var fourth := randi_range(0, 255)
	
	return "%d.%d.%d.%d" % [first, second, third, fourth]
