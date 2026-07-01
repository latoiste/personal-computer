class_name Taskbar
extends HBoxContainer

@onready var notepad: TextureButton = $Notepad
@onready var terminal: TextureButton = $Terminal
@onready var notif: TextureButton = $Notification
@onready var shop: TextureButton = $Shop
@onready var launcher: TextureButton = $Launcher

signal launcher_icon_pressed
signal terminal_icon_pressed
signal notepad_icon_pressed
signal notification_icon_pressed
signal shop_icon_pressed

const NOTIFICATION_ICON_UNREAD = preload("uid://conupe1lq7jdb")
const NOTIFICATION_ICON_UNREAD_HOVER = preload("uid://dpbgnoha50kvf")
const NOTIFICATION_ICON_UNREAD_PRESSED = preload("uid://b7sqdx7gwmrio")
const NOTIFICATION_ICON = preload("uid://ds70o4br2x6q3")
const NOTIFICATION_ICON_HOVER = preload("uid://0ao5rr0obpbt")
const NOTIFICATION_ICON_PRESSED = preload("uid://be2myafmu1mgc")

func _ready() -> void:
	launcher.pressed.connect(launcher_icon_pressed.emit)
	terminal.pressed.connect(terminal_icon_pressed.emit)
	notepad.pressed.connect(notepad_icon_pressed.emit)
	notif.pressed.connect(notification_icon_pressed.emit)
	shop.pressed.connect(shop_icon_pressed.emit)
	launcher.pressed.connect(SaveManager.save_game)

func notif_icon_unread() -> void:
	notif.texture_normal = NOTIFICATION_ICON_UNREAD
	notif.texture_hover = NOTIFICATION_ICON_UNREAD_HOVER
	notif.texture_pressed = NOTIFICATION_ICON_UNREAD_PRESSED

func notif_icon_read() -> void:
	notif.texture_normal = NOTIFICATION_ICON
	notif.texture_hover = NOTIFICATION_ICON_HOVER
	notif.texture_pressed = NOTIFICATION_ICON_PRESSED
