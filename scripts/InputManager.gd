extends Node

signal im_click(pos)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton: 
		if event.button_index == 1 && event.pressed:
			emit_signal("im_click",event.position)
