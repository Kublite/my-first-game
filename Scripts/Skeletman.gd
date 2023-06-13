extends KinematicBody2D 

onready var ui = get_viewport().get_node("Root/UI/Control")

var speed = 200 
onready var hp = 100
export var max_hp =100

func _ready():
	set_start_hp(hp, max_hp)
	pass 
	
func set_start_hp(hp, max_hp):
	$HP_bar.value = hp
	$HP_bar.max_value = max_hp
	
func update_hp():
	$HP_bar.value = hp

func reduce_hp(val):
	self.hp -= val
	update_hp()
	
func save():
	var data = {
		"filename": get_filename(),
		"position": position,
		"speed":speed,
		"hp":hp,
		"max_hp":max_hp
	}
	return data
