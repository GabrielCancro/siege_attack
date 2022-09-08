extends Node

var castle_index = -1
var castles_nodes = [
	preload("res://castles/Castle1.tscn"),
	preload("res://castles/Castle2.tscn"),
	preload("res://castles/Castle3.tscn"),
]
var rocks_types = [
	["standar","standar","standar","standar","standar","standar","standar"],
	["standar","standar","standar","standar","standar","standar","standar"],
	["standar","standar","standar","standar","standar","standar","standar","standar","standar"],
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
