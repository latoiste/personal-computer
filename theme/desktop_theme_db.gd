extends Node

func _ready() -> void:
	var unlocked_wallpaper_id := SaveManager.load_unlocked_wallpaper()
	for id in unlocked_wallpaper_id:
		var wallpaper = WALLPAPER_STORE[id]
		if wallpaper:
			wallpaper.unlocked = true

var WALLPAPER_STORE = {
	"wallpaper_default": {
		"display": "Default",
		"price": 0,
		"unlocked": true,
		"texture_path": "uid://d3avp8vu6ofoq"
	},
	"wallpaper_cat": {
		"display": "Cat",
		"price": 100,
		"unlocked": false,
		"texture_path": "uid://c5wesiq5en1wh"
	},
	"wallpaper_flower": {
		"display": "Flowers",
		"price": 100,
		"unlocked": false,
		"texture_path": "uid://dxmg3t3m4fhol"
	},
}
