extends Control
signal next()
signal quit()
@onready var player = $AnimationPlayer
# Called when the node enters the scene tree for the first time.
func _ready():
	player.play("glimmer")
	await player.animation_finished
	$Options.show()
func _on_next_pressed():
	next.emit()


func _on_quit_pressed():
	print("quit")
	quit.emit()
