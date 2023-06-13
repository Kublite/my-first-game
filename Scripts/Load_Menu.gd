extends Control

onready var file_to_load = ""

signal on_close_menu
signal on_loaded(data)

func _ready():
	hide()
	
func open():
	show()
