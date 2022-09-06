extends Node2D

func _ready():
	pass

func _process(delta):
	if $Arm.angular_velocity <= 0: $Arm.angular_velocity = -1
	
func move(val):
	if(abs($Base.position.x+val*10)>100): return
	$Base.linear_velocity = Vector2(val,0)*60

func set_power(val):
	$Base/Label.text = str(floor(val*100))+"%"

func shoot(val):
	$Arm.angular_velocity = 6+val*12
