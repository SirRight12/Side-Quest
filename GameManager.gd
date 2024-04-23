extends Control
@onready var view = $View
@onready var game = $Game
@export var starting_level = load("res://level_1.tscn")
@onready var game_over_scene = load("res://game_over.tscn")
func run_level(level_scene):
	var level = level_scene.instantiate()
	game.add_child(level)
	await level.game_over
	var g_o = game_over_scene.instantiate()
	print(g_o)
	view.add_child(g_o)
	g_o.restart.connect(restart)
	g_o.quit.connect(quit)
func _ready():
	run_level(starting_level)
func restart():
	game.remove_child($Game/Node2D)
	view.remove_child($View/GameOver)
	run_level(starting_level)
func quit():
	get_tree().quit()
