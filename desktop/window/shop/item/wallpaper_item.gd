class_name WallpaperItem
extends ShopItem

func apply_theme() -> void:
	ThemeManager.wallpaper_changed.emit(id)

func buy_item() -> void:
	super.buy_item()
	var item = DesktopThemeDB.WALLPAPER_STORE[id] as Dictionary
	item.unlocked = true
	SaveManager.save_unlocked_wallpaper(id)
