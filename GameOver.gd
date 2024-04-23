extends Control
signal restart()
signal quit()
@onready var anim = $AnimationPlayer
@onready var replay = $Replay
@onready var replay_button = $"Replay/Replay Button"
@onready var quit_button = $"Replay/Quit"
func _ready():
	anim.play("Game Over")
	await anim.animation_finished
	replay.visible = true
	replay_button.connect("pressed",restart_press)
	quit_button.connect("pressed",quit_press)
func restart_press():
	print('res')
	replay_button.disconnect("pressed",restart_press)
	quit_button.disconnect("pressed",quit_press)
	restart.emit()
func quit_press():
	replay_button.disconnect("pressed",restart_press)
	quit_button.disconnect("pressed",quit_press)
	quit.emit()
