extends Button

@export var number = 1
@onready var GameManager = $"../.."

func _on_button_down() -> void:
	GameManager.numPlayers = number
	GameManager.gotPlayers = true
