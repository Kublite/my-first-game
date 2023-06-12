extends Resource

onready var save_name = "" setget set_name
onready var data = {} setget set_data, get_data


func set_name(n):
	save_name = n

func set_data(d):
	data= d.duplicate(true)
	
func get_data():
	return data
