class_name CreditsManager
extends Node

var credits: int = 1000

signal credits_changed(new_amount: int)

func _ready() -> void:
	credits = SaveManager.load_credits()
	credits_changed.connect(SaveManager.save_credits)

func add_credits(amount: int) -> void:
	credits = clampi(credits + amount, 0, 9999)
	credits_changed.emit(credits)

func subtract_credits(amount: int) -> void:
	credits = clampi(credits - amount, 0, 9999)
	credits_changed.emit(credits)
