extends RigidBody2D

var isDead = false


# Called when the node enters the scene tree for the first time.
func _ready():
	$Area2D.connect("body_entered",self,"onCollision")
	get_node("/root/Main").add_enemy(1)

func onCollision(body):
	if isDead: return
	print(body.name)
	isDead = true	
	$Blood.emitting = true
	$AudioStreamPlayer2D.play()
	yield(get_tree().create_timer(.7),"timeout")
	get_node("/root/Main").add_enemy(-1)
	yield(get_tree().create_timer(.7),"timeout")
	queue_free()
	

func _process(delta):
	if !isDead: return
	$AnimatedSprite.modulate.a -= 0.01
