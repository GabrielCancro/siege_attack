extends Node2D

var ROCK_SCENE = preload("res://blocks/Rock1.tscn")
var enemies_counter = 0
var force = 500
var angle = 45
var current_rock = null

func _ready():
	randomize()
	InputManager.connect("im_click",self,"onClick")
	update_ui()

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		angle = min(angle+5,60)
		update_ui()
	if Input.is_action_just_pressed("ui_down"):
		angle = max(angle-5,10)
		update_ui()
	if Input.is_action_just_pressed("ui_right"):
		force = min(force+20,600)
		update_ui()
	if Input.is_action_just_pressed("ui_left"):
		force = max(force-20,400)
		update_ui()
	if Input.is_action_just_pressed("ui_accept"):
		onClick(null)
	if current_rock: 
		$Camera2D.position.x = current_rock.position.x+150
		print(current_rock.linear_velocity.length())
		if current_rock.linear_velocity.length() < 2: 
			current_rock = null
	else: 
		$Camera2D.position.x = 500
	

func onClick(pos):
	if current_rock: return
	var b = ROCK_SCENE.instance()
	b.position = $Catapult.position + Vector2(0,-100)
	b.linear_velocity = polar2cartesian(force,deg2rad(-angle))
	b.angular_velocity = 5
	b.mass = .3
	add_child(b)
	current_rock = b
	$Catapult/AnimationPlayer.play("asault")

func add_enemy(val):
	enemies_counter += val
	update_ui()

func update_ui():
	$UI/lb_fg.text = str(force)+"f\n"+str(angle)+"*"
	$UI/lb_enemies.text = str(enemies_counter)
	if enemies_counter <=0: $UI/lb_end_game.visible = true
