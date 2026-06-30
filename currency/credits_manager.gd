class_name CreditsManager
extends Node

var credits: int

signal credits_changed(new_amount: int)

func add_credits(amount: int) -> void:
	print("credits added")
	credits = clampi(credits + amount, 0, 9999)
	credits_changed.emit(credits)

func subtract_credits(amount: int) -> void:
	credits = clampi(credits - amount, 0, 9999)
	credits_changed.emit(credits)
