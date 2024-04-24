extends Resource
class_name QueueManager
var queue:Array[bool]
var delay = 1000
var sleeping = true
var tree:SceneTree
signal queue_reached()
signal sleep()
func add_queue():
	queue.append(true)
	update_queue()
	pass
func timeout(time):
	if !tree:
		printerr("No tree provided for QueueManager")
	time = time / 1000
	var timer = tree.create_timer(time)
	await timer.timeout
	return true
func update_queue():
	if !sleeping: return
	run_queue()
func run_queue():
	sleeping = false
	await timeout(delay)
	queue.pop_front()
	queue_reached.emit()
	if queue.size() <= 0:
		sleeping = true
		sleep.emit()
		return
	run_queue()
