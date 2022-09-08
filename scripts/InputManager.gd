extends Node

signal im_click(pos)


func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton: 
		if event.button_index == 1 && event.pressed:
			emit_signal("im_click",event.position)
