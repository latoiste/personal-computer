class_name Main
extends Control

@onready var request_timer: Timer = $RequestTimer
@onready var screen: Screen = $Screen
@onready var notif: NotificationWidget = $Screen/Notification
@onready var request_manager: RequestManager = $RequestManager

const MIN_WAIT_TIME := 5
const MAX_WAIT_TIME := 5

var requests: Array[Request] = [
	Request.new("Sorting Order", "Need help sorting my files to seperate folders", 50, 300, ["help", "sort"]),
	#Request.new("Cache Clearing", "Looking for someone to help clear my blogs cache", 60, 480),
	#Request.new("Storage Clean up", "too much bloat, help clean", 75, 600),
]

func _ready() -> void:	
	notif.request_accepted.connect(request_manager.on_request_accepted)
	request_timer.timeout.connect(spawn_new_request)
	
	screen.request_manager = request_manager
	
	wait_for_request()

func spawn_new_request() -> void:
	var index := randi() % len(requests)
	screen.on_new_request(requests[index].clone())
	
	wait_for_request()

func wait_for_request() -> void:
	var wait_time := randi_range(MIN_WAIT_TIME, MAX_WAIT_TIME)
	request_timer.wait_time = wait_time
	
	request_timer.start()
