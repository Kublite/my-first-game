extends "res://Scripts/Skeletman.gd"
var stands = true
var destination = Vector2()
var velocity = Vector2()
var target = null
var default_speed = 50
onready var animGoblin = $AnimationPlayer
onready var sprite =$Sprite


func _ready():
	speed = default_speed

func _process(delta):
	if velocity:
		var collision = move_and_collide(velocity * delta)
		if collision:
			# Обработка столкновения
			velocity = velocity.bounce(collision.normal)
		position.x = clamp(position.x, 0 ,10000)
		position.y = clamp(position.y, 0 ,10000)
	wander()
	search_for_target()
	
func search_for_target():
	var pl = get_parent().get_parent().get_player()
	if target:
		if position.distance_to(target.position) >200:
			cancel_movement()
		else:
			set_destination(target.position)
		
	elif position.distance_to(pl.position)<200:
		cancel_movement() 
		speed = default_speed *2 if speed == default_speed else speed
		target = pl

func set_destination(dest):
	destination = dest
	velocity = (destination - position).normalized() * speed
	
	animGoblin.play("run")
	if sign(sprite.scale.x) != sign(velocity.x):
		sprite.scale.x *= -1
	stands = false

func cancel_movement():
	animGoblin.play("idle")
	velocity = Vector2()
	destination = Vector2()
	speed = default_speed
	$StandingTimer.start(2)
	target = null

func wander():
	var pos = position
	if stands:
		randomize()
		var x = int(rand_range(pos.x - 150, pos.x + 150))
		var y = int(rand_range(pos.y - 150, pos.y + 150))
		x = clamp(x, 0, 10000)
		y = clamp(y, 0, 10000)
		set_destination(Vector2(x,y))
	elif velocity != Vector2() and not target:
		if pos.distance_to(destination) <= speed:
			cancel_movement()

func _on_StandingTimer_timeout():
	stands = true
