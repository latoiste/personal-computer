class_name Wallpaper
extends TextureRect

func _ready() -> void:
	ThemeManager.wallpaper_changed.connect(change_wallpaper)
	var wallpaper_id := SaveManager.load_wallpaper_id()
	change_wallpaper(wallpaper_id)

func change_wallpaper(id: String) -> void:
	var path = DesktopThemeDB.WALLPAPER_STORE[id].texture_path
	if path:
		var wallpaper := load(path)
		texture = wallpaper
		SaveManager.save_wallpaper_id(id)
	
