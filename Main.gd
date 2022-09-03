extends Node2D

var BLOCK_SCENE = preload("res://blocks/Block_1x1.tscn")

func _ready():
	randomize()
#	create_blocks()
	InputManager.connect("im_click",self,"onClick")

func create_blocks():
	for i in range(10):
		var b = BLOCK_SCENE.instance()
		b.position = Vector2(400+rand_range(-100,100),-i*70)
		add_child(b)

func onClick(pos):
	var b = BLOCK_SCENE.instance()
	b.position = pos
	b.linear_velocity = Vector2(500,-100)
	b.angular_velocity = 5
	b.mass = .3
	add_child(b)
