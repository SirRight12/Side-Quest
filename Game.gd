extends Node2D
signal game_over()


func _on_player_died():
	game_over.emit()
