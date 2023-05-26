extends "res://Scripts/Skeletman.gd"
var inventory={}

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

