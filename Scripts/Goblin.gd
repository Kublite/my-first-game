extends "res://Scripts/Skeletman.gd"
var stands = true
var destination = Vector2()
var velocity = Vector2()
var target = null
var default_speed = 20
onready var animGoblin = $AnimationGoblin
onready var sprite =$Sprite
var target_intercepted = false
var can_bite = true
var bite_strenght = 5

func _ready():
	speed = default_speed
	self.hp = 60
	self.max_hp = 60
	set_start_hp(self.hp, self.max_hp)
	add_to_group(GlobalVars.entity_group)
	add_to_group(GlobalVars.mob_group)

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
	
	if target_intercepted and can_bite:
		bite(target)
	
func search_for_target():
	var pl = get_parent().get_parent().get_player()
	if target:
		if position.distance_to(target.position) >100:
			cancel_movement()
		else:
			set_destination(target.position)
		
	elif position.distance_to(pl.position)<100:
		cancel_movement() 
		speed = default_speed *3 if speed == default_speed else speed
		target = pl

func set_destination(dest): 
	destination = dest
	velocity = (destination - position).normalized() * speed
	if sign(sprite.scale.x) != sign(velocity.x):
		sprite.scale.x *= -1
	animGoblin.play("run")
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
		var x = int(rand_range(pos.x - 50, pos.x + 50))
		var y = int(rand_range(pos.y - 50, pos.y + 50))
		x = clamp(x, 0, 10000)
		y = clamp(y, 0, 10000)
		set_destination(Vector2(x,y))
	elif velocity != Vector2() and not target:
		if pos.distance_to(destination) <= speed:
			cancel_movement()

func _on_StandingTimer_timeout():
	stands = true


func bite(targ):
	animGoblin.play("Attack")
	targ.reduce_hp(bite_strenght) 
	can_bite = false
	$BiteCooldown.start(0.8)


func _on_BiteCooldown_timeout():
	can_bite = true
	animGoblin.play("idle")
	pass # Replace with function body.


func _on_BiteArea_area_entered(area):
	if area.get_parent() == target:
		target_intercepted = true
	pass # Replace with function body.


func _on_BiteArea_area_exited(area):
	if area.get_parent() == target:
		target_intercepted = false
	pass # Replace with function body.
