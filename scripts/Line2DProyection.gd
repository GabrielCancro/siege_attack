extends Line2D

var t = 0
var i_pos = Vector2(70,320)
onready var MAIN = get_node("/root/Main")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var dY = (t*t)/10
	var i_vel = polar2cartesian(MAIN.force,deg2rad(-MAIN.angle)) / 50
	position = i_pos + i_vel*t + Vector2(0,dY)
	if t<100: t+=1
	else: t=0
