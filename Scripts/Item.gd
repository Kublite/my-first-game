extends Node2D 

var item = "" 

func set_item(item_name): 
	$Sprite.texture = load("res://Sprites/Items/%s.png" % item_name) 
	item = item_name 

func _ready(): 
	pass 
