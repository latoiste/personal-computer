class_name NotificationWidget
extends NinePatchRect

@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer/ScrollContainer/VBoxContainer

const MAX_NOTIFICATIONS = 5
const NOTIFICATOIN_ITEM_SCENE := preload("uid://vujqsq8xd2h")

signal request_accepted(request: Request)

func new_notification(request: Request) -> void:
	if v_box_container.get_child_count() >= MAX_NOTIFICATIONS:
		return
	var notif_item := NOTIFICATOIN_ITEM_SCENE.instantiate() as NotificationItem
	notif_item.request_accepted.connect(func(req: Request): request_accepted.emit(req))
	
	v_box_container.add_child(notif_item)
	notif_item.set_request(request)
