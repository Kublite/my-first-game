extends "res://Scripts/Skeletman.gd"

var stands = true
var destination = Vector2()
var velocity = Vector2()
var prev_pos = Vector2()
var target = null
var default_speed = 70

func _ready():
	speed = default_speed
	$StandingTimer.start(2)

func _process(delta):
	if velocity:
		prev_pos = position
		move_and_slide(velocity)
		position.x = clamp(position.x, 0 ,10000)
		position.y = clamp(position.y, 0 ,10000)
	wander()
	search_for_target()

func search_for_target():
	var pl =  get_parent().get_parent().get_player()
	if position.distance_to(pl.position) < 200:
		cancel_movement()
		speed = default_speed * 3
		target = pl
		set_destination(target.position)
	else:
		if stands == true:
			speed = default_speed
			set_destination(Vector2())

func set_destination(dest):
	destination = dest
	velocity = (destination - position).normalized() * speed
	stands = false

func cancel_movement():
	velocity = Vector2()
	stands = true
	$StandingTimer.start(2)

func wander():
	var pos = position
	if stands:
		randomize()
		var x = int(rand_range(pos.x - 300, pos.x + 300))
		var y = int(rand_range(pos.y - 300, pos.y + 300))
		x = clamp(x, 0, 10000)
		y = clamp(y, 0, 10000)
		set_destination(Vector2(x,y))
	elif velocity != Vector2() and pos.distance_to(destination) <= speed:
		cancel_movement()

func _on_StandingTimer_timeout():
	stands = true
