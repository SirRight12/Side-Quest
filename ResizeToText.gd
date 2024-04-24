@tool
extends SubViewport
@export var enabled = true

func _process(delta):
	if !enabled: return
	size = $Label.size * $Label.scale
	pass
