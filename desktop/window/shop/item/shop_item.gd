class_name ShopItem
extends VBoxContainer

@onready var texture_button: TextureButton = $TextureButton
@onready var display_text: Label = $VBoxContainer/DisplayText
@onready var price_text: Label = $VBoxContainer/PriceText
@onready var double_click_timer: Timer = $DoubleClickTimer

const DOUBLE_CLICK_WINDOW := 0.4

var id: String
var display: String
var price: int
var unlocked: bool
var texture_path: String

signal double_clicked(item: ShopItem)
signal item_bought(price: int)

func _ready() -> void:
	texture_button.texture_normal = load(texture_path)
	display_text.text = display
	if !unlocked:
		price_text.text = "(%s Credits)" % price
	
	texture_button.pressed.connect(try_double_click)
	double_click_timer.timeout.connect(double_click_timer.stop)
	
	await get_tree().process_frame
	custom_minimum_size.x = size.x

func initialize(id: String, display: String, price: int, unlocked: bool, texture_path: String) -> void:
	self.id = id
	self.display = display
	self.price = price
	self.unlocked = unlocked
	self.texture_path = texture_path

func try_double_click() -> void:
	if double_click_timer.is_stopped():
		double_click_timer.start(DOUBLE_CLICK_WINDOW)
		return
	
	double_clicked.emit(self)

func buy_item() -> void:
	unlocked = true
	price_text.text = ""
	
	item_bought.emit(price)

func apply_theme() -> void:
	pass
