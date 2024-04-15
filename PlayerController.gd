extends CharacterBody2D


const SPEED = 500.0
@onready var cannon:Marker2D = $Cannon
var bullets:PackedScene = preload("res://laser.tscn")
@export var added_speed:int = 10
@export var fire:bool:
	set = set_fire
func set_fire(val):
	fire = false
	shoot()
func shoot():
	var bullet:Bullet = bullets.instantiate()
	$"..".add_child(bullet)
	bullet.set_position(cannon.get_global_position())
	bullet.fire(added_speed)
func _physics_process(delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if Input.is_action_just_released("shoot"):
		shoot()
	var direction = Input.get_vector("left","right","up","down")
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()
