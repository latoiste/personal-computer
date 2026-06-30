class_name WallpaperItem
extends ShopItem

func apply_theme() -> void:
	print('hai')
	ThemeManager.wallpaper_changed.emit(texture_path)
