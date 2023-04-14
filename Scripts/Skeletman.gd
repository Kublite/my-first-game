extends KinematicBody2D 

onready var ui = get_viewport().get_node("Root/UI/Control")

var speed = 200 
var items = 0
var inventory={}

func _ready(): 
	pass 
	
func pick(item):
	var it = item.get_name()
	if it in inventory.keys():
		inventory[it] += item.get_amount()
	else:
		inventory[it] = item.get_amount()
	ui.update_inventory(inventory)
# warning-ignore:unused_argument
func _process(delta): 

	var velocity = Vector2() 
	if Input.is_action_pressed("up"): 
		velocity.y-=speed 
	if Input.is_action_pressed("down"): 
		velocity.y+=speed 
	if Input.is_action_pressed("left"): 
		velocity.x-=speed 
	if Input.is_action_pressed("right"): 
		velocity.x+=speed 
# warning-ignore:return_value_discarded
	move_and_slide(velocity) 


	position.x = clamp(position.x, 0,10000) 
	position.y = clamp(position.y, 0,10000) 

func _unhandled_input(event):
	if event.is_action_pressed("inventory"):
		ui.toggle_inventory(inventory)
