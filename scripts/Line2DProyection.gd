extends Line2D

var t = 0
var i_pos = Vector2(70,320)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(delta):
	var a = get_node("/root/Main").angle
	var F = get_node("/root/Main").force
	var dX = t
	var dY = 100 - (t*t)/10
	position = i_pos - Vector2(dX,dY)
	if t<100: t+=1
	else: t=0
