extends Node2D 

var item = "" 
var amount = 1
var stack_limit = 16

func set_item(item_name): 
	$Sprite.texture = load("res://Sprites/Items/%s.png" % item_name) 
	item = item_name 

func _ready(): 
	pass 

func get_item():
	return item

func get_amount():
	return amount 
	
func get_item_stack():
	return stack_limit

func _input(event):
	if event.is_action_pressed("e_click"):
		var pl = get_parent().get_parent().get_player()
		if abs(pl.position.x - position.x) < 40 and abs(pl.position.y - position.y) < 40:
			get_parent().remove_child(self)
			pl.pick(self)
