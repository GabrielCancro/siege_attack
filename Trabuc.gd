extends Node2D

func _ready():
	set_down(false)

func set_down(val):
	pass

func _process(delta):
	if $Arm.angular_velocity <= 0: $Arm.angular_velocity = -1
	$Label.text = str( floor($Arm.rotation_degrees) )
	
	
func shoot(val):
	$Arm.angular_velocity = 15+val
