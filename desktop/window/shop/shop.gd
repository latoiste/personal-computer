class_name Shop
extends DesktopWindow

@onready var tab_container: TabContainer = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/TabContainer
@onready var wallpaper_store: GridContainer = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/TabContainer/Wallpapers/GridContainer
@onready var credits_text: Label = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/MarginContainer/Label

const SHOP_ITEM_SCENE = preload("uid://3t5qm57kpeau")

var credits_manager: CreditsManager

func _ready() -> void:
	super._ready()
	
	credits_text.text = "Credits: %s" % credits_manager.credits
	credits_manager.credits_changed.connect(func(new_credits: int): credits_text.text = "Credits: %s" % new_credits)
	
	for key in DesktopThemeDB.WALLPAPER_STORE.keys():
		var value = DesktopThemeDB.WALLPAPER_STORE[key]
		var wallpaper_item := SHOP_ITEM_SCENE.instantiate() as ShopItem
		wallpaper_item.set_script(load("uid://bv020jmcncfg1"))
		wallpaper_item.initialize(key, value["display"], value["price"], value["unlocked"], value["texture_path"])
		
		wallpaper_item.item_bought.connect(credits_manager.subtract_credits)
		wallpaper_item.double_clicked.connect(try_buy_item)
		
		wallpaper_store.add_child(wallpaper_item)

func initialize(credits_manager: CreditsManager) -> void:
	self.credits_manager = credits_manager

func try_buy_item(item: ShopItem) -> void:
	if item.unlocked:
		item.apply_theme()
	elif credits_manager.credits >= item.price:
		item.buy_item()
