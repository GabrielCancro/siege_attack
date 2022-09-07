extends Node2D

func _ready():
	pass

func _process(delta):
	if $Arm.angular_velocity <= 0: $Arm.angular_velocity = -1
	
func move(val):
	if (val>0 && $Base.position.x<60): $Base.linear_velocity = Vector2(60,0)
	if (val<0 && $Base.position.x>-130): $Base.linear_velocity = Vector2(-60,0)
	print($Base.position.x)

func set_power(val):
	$Base/Label.text = str(floor(val*100))+"%"

func shoot(val):
	$Arm.angular_velocity = 6+val*12
