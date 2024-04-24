extends Node2D
signal game_over(died)
func _ready():
	$Spawner.enemies_reached.connect(_on_spawner_enemies_reached)
	$Player.died.connect(_on_player_died)

func _on_player_died():
	$Player.died.disconnect(_on_player_died)
	$Spawner.enemies_reached.disconnect(_on_spawner_enemies_reached)
	game_over.emit(true)


func _on_spawner_enemies_reached():
	$Player.died.disconnect(_on_player_died)
	$Spawner.enemies_reached.disconnect(_on_spawner_enemies_reached)
	$Player.SPEED = 0.0
	$Player.velocity = Vector2.ZERO
	$Player.can_fire = false
	game_over.emit(false)
