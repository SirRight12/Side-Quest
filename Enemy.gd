extends Area2D
class_name Enemy
signal died()
@export var max_hp:int = 1
@onready var hp = max_hp
@export var speed:int = 500
@export var life_time = 10
var enabled = false
# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(area_enter)
	body_entered.connect(body_enter)
	pass # Replace with function body.
func body_enter(body:CollisionObject2D):
	if body.is_in_group("player"):
		body.queue_free()
		body.died.emit()
		queue_free()
func area_enter(area:Area2D):
	if area.is_in_group("bullet"):
		hp -= area.damage
		area.queue_free()
		if hp <= 0:
			died.emit()
			queue_free()
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !enabled: return
	position.y += speed * delta
	pass
func timeout(time):
	var timer = get_tree().create_timer(time)
	await timer.timeout
	return true
func launch():
	enabled = true
	await timeout(life_time)
	died.emit()
	enabled = false
	queue_free()
