extends "res://Scripts/Skeletman.gd"
var inventory={}
onready var animationPlayer = $AnimationPlayer 
const acc = 500
const max_speed = 80
const friction = 500
var velocity= Vector2.ZERO 
onready var sprite = $Sprite 

func _ready():
	self.hp = 100
	set_start_hp(self.hp, self.max_hp)
	add_to_group(GlobalVars.entity_group)
	
func pick(item):
	var it = item.get_item()
	if it in inventory.keys():
		inventory[it][0] += item.get_amount()
	else:
		inventory[it] = [item.get_amount(),item.get_item_stack()]
	ui.update_inventory(inventory)
	# warning-ignore:unused_argument
	
func _physics_process(delta): 
	var input_vector = Vector2.ZERO 
	input_vector.x = Input.get_action_strength("right")-Input.get_action_strength("left") 
	input_vector.y = Input.get_action_strength("down")-Input.get_action_strength("up") 
	input_vector = input_vector.normalized() 

	if input_vector != Vector2.ZERO: 
		animationPlayer.play("Run") 
		if input_vector.x != 0 and sign(sprite.scale.x)!=sign(input_vector.x): 
			sprite.scale.x *= -1 
		velocity = velocity.move_toward(input_vector * max_speed, acc * delta) 
	else: 
		animationPlayer.play("Idle") 
		velocity = velocity.move_toward(Vector2.ZERO, friction * delta)  
	velocity = move_and_slide(velocity) 


func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		ui.toggle_inventory(inventory)


func save():
	var data = .save()
	data["inventory"]= inventory
	return data
