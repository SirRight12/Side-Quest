extends Node

@export var enemies:Array[PackedScene]
@export var spawn_area_one:Vector2i
@onready var spawn_area_two = spawn_area_one * Vector2i(-1,1)
var queue = QueueManager.new()
#@export var test_spawn:bool:
	#set = set_test_spawn
#func set_test_spawn(val):
	#test_spawn = false
	#spawn_enemy()
func spawn_enemy():
	var rand_x = randi_range(spawn_area_two.x,spawn_area_one.x)
	var enemy = get_random_enemy().instantiate()
	$"..".call_deferred("add_child",enemy)
	await enemy.ready
	enemy.set_position(Vector2(rand_x,spawn_area_one.y))
	enemy.launch()
	print("enemy added")
# Called when the node enters the scene tree for the first time.
func spawn_x_enemies(x):
	for y in x:
		queue.add_queue()
		print("added to queue")
	queue.queue_reached.connect(spawn_enemy)
	await queue.sleep
	queue.queue_reached.disconnect(spawn_enemy)
func _ready():
	queue.tree = get_tree()
	spawn_x_enemies(100)
	pass
func get_random_enemy():
	return enemies[randi_range(0,enemies.size() - 1)]

func add_spawn_queue():
	queue.append(true)
	
