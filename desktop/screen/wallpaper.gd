class_name Wallpaper
extends TextureRect

func _ready() -> void:
	ThemeManager.wallpaper_changed.connect(change_wallpaper)

func change_wallpaper(path: String) -> void:
	var wallpaper := load(path)
	texture = wallpaper
