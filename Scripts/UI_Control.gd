extends Control

onready var pack = $Panel

func toggle_inventory(inventory):
	if pack.visible:
		pack.clear()
		pack.visible = false
	else:
		pack.visible = true
		pack.show_inventory(inventory)

func update_inventory(inventory):
	if pack.visible:
		pack.show_inventory(inventory)
 
func _unhandled_input(event):
	if event.is_action_pressed("esc"):
		$Menu.open()
