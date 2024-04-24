extends Node
signal enemies_reached()
@export var enemies:Array[PackedScene]
@export var enemies_to_spawn: int = 10
@export var spawn_area_one:Vector2i = Vector2i(576,-324)
@onready var spawn_area_two = spawn_area_one * Vector2i(-1,1)
var alive_enemies:Array[bool] = []
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
	enemy.died.connect(remove_enemy)
	enemy.set_position(Vector2(rand_x,spawn_area_one.y))
	enemy.launch()
func remove_enemy():
	alive_enemies.pop_back()
	if alive_enemies.size() <= 0:
		enemies_reached.emit()
func spawn_x_enemies(x):
	for y in x:
		alive_enemies.append(true)
		queue.add_queue()
	queue.queue_reached.connect(spawn_enemy)
	await queue.sleep
	queue.queue_reached.disconnect(spawn_enemy)
func _ready():
	queue.tree = get_tree()
	spawn_x_enemies(enemies_to_spawn)
	pass
func get_random_enemy():
	return enemies[randi_range(0,enemies.size() - 1)]

func add_spawn_queue():
	queue.append(true)
	
