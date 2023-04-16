extends "res://Scripts/Skeletman.gd"

var stands = true
var destination = Vector2()
var velocity = Vector2()



func _ready():
	speed = 145

# warning-ignore:unused_argument
func _process(delta):
	if velocity:
# warning-ignore:return_value_discarded
		move_and_slide(velocity)
		position.x = clamp(position.x, 0 ,10000)
		position.y = clamp(position.y, 0 ,10000)
	wander()

func set_destination(dest):
	destination = dest
	velocity = (destination - position).normalized()*speed
	stands = false

func cancel_movement():
	velocity = Vector2()
	destination = Vector2()
	$StandingTimer.start(2)

func wander():
	var pos = position
	if stands:
		randomize()
		var x = int(rand_range(pos.x - 150, pos.x + 150))
		var y = int(rand_range(pos.x - 150, pos.x + 150))
		
		x = clamp(x, 0, 10000)
		y = clamp(x, 0, 10000)
		
		set_destination(Vector2(x,y))
		
	elif velocity != Vector2():
		if pos.distance_to(destination) <= speed:
			cancel_movement()

func _on_StandingTimer_timeout():
	stands = true
	pass # Replace with function body.
