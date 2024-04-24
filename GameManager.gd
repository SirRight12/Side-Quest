extends Control
@onready var view = $View
@onready var game = $Game
@export var levels:Array[PackedScene]
@export var level = 0
@onready var game_over_scene = load("res://game_over.tscn")
@onready var win_scene = load("res://win.tscn")
func run_level(level_scene):
	var level = level_scene.instantiate()
	game.add_child(level)
	level.game_over.connect(on_game_end)
	
func game_over():
	var g_o = game_over_scene.instantiate()
	view.add_child(g_o)
	g_o.restart.connect(restart)
	g_o.quit.connect(quit)
func on_game_end(died):
	if died:
		game_over()
	else:
		win()
func win():
	var w = win_scene.instantiate()
	view.add_child(w)
	w.next.connect(next_level)
	w.quit.connect(quit)
func next_level():
	level += 1
	view.remove_child($View/Win)
	game.remove_child($Game/Node2D)
	if level >= levels.size():
		return
	run_level(levels[level])
func _ready():
	run_level(levels[level])
func restart():
	game.remove_child($Game/Node2D)
	view.remove_child($View/GameOver)
	run_level(levels[level])
func quit():
	get_tree().quit()
