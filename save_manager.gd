extends Node

var save_data: SaveFile

const SAVE_PATH := "user://save_file.json"

func save_game() -> void:
	var data := {
		"credits": save_data.credits,
		"wallpaper_id": save_data.wallpaper_id,
		"unlocked_wallpaper_id": save_data.unlocked_wallpaper_id,
	}
	
	var json_string := JSON.stringify(data, "\t")
	
	var file := FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file:
		file.store_string(json_string)
		file.close()

func save_credits(credits: int) -> void:
	save_data.credits = credits

func save_wallpaper_id(wallpaper_id: String) -> void:
	save_data.wallpaper_id = wallpaper_id

func save_unlocked_wallpaper(unlocked_wallpaper_id: String) -> void:
	save_data.unlocked_wallpaper_id.append(unlocked_wallpaper_id)

func load_game() -> void:
	if not FileAccess.file_exists(SAVE_PATH):
		save_data = SaveFile.new()
		return
	
	var json_string := FileAccess.get_file_as_string(SAVE_PATH)
	if json_string.is_empty():
		save_data = SaveFile.new()
		return
	
	var data = JSON.parse_string(json_string)
	if data:
		var credits = data["credits"]
		var wallpaper_id = data["wallpaper_id"]
		var unlocked_wallpaper_id = data["unlocked_wallpaper_id"]
		save_data = SaveFile.new(credits, wallpaper_id, unlocked_wallpaper_id)
	else:
		save_data = SaveFile.new()

func load_credits() -> int:
	if !save_data:
		load_game()
	return save_data.credits

func load_wallpaper_id() -> String:
	if !save_data:
		load_game()
	return save_data.wallpaper_id

func load_unlocked_wallpaper() -> Array:
	if !save_data:
		load_game()
	return save_data.unlocked_wallpaper_id

class SaveFile:
	var credits: int
	var wallpaper_id: String
	var unlocked_wallpaper_id: Array
	
	func _init(credits: int = 0, wallpaper_id: String = "default", unlocked_wallpaper_id: Array = []) -> void:
		self.credits = credits
		self.wallpaper_id = wallpaper_id
		self.unlocked_wallpaper_id = unlocked_wallpaper_id
