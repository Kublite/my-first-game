extends Node2D 

onready var item = preload("res://Scenes/Item.tscn") 

func get_player():
	return $Player

func update_label(value):
	get_parent().update_label(value)

func _ready(): 
	var items = [["rock", 5], ["rope", 16], ["Stick", 10]] 
	for i in range(100): 
		randomize() 
		var a = int(rand_range(0, 3)) 
		var new_item = item.instance() 
		$Items.add_child(new_item) 
		new_item.set_item(items[a]) 
		new_item.position = Vector2(int(rand_range(0, 1000)), int(rand_range(0, 500))) 
	pass 
