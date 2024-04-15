extends Area2D
class_name Bullet
var enabled = false
var speed = 0.0
@export var life_time = 1
@export var base_speed:int = 100
@export var damage:int = 1
# Called when the node enters the scene tree for the first time.
func _ready():
	fire(10)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !enabled: return
	position.y -= speed * delta
func fire(fire_speed):
	speed = fire_speed + base_speed
	enabled = true
	await timeout(life_time)
	enabled = false
	queue_free()
func timeout(seconds):
	var timer = get_tree().create_timer(seconds)
	await timer.timeout
	return true
