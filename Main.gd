extends Node2D

var ROCK_SCENE = preload("res://blocks/Rock1.tscn")
var enemies_counter = 0
var force = 500
var angle = 45
var current_rock = null
var shadow_rock_1 = null
var shadow_rock_2 = null
var power = 0
var isReady = true

func _ready():
	randomize()
	InputManager.connect("im_click",self,"onClick")
	$ShadowsRocks.connect("timeout",self,"add_shadow_rock")
	$Trabuc.connect("on_reload",self,"create_new_trabuc_rock")
	update_ui()
	create_new_trabuc_rock()
	

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
#	if Input.is_action_just_pressed("ui_accept"):
#		onClick(null)
	if Input.is_action_pressed("ui_accept"):
		if isReady: power = min(power+.2,20)
	if Input.is_action_just_released("ui_accept"): 
		if power != 0 && isReady: 
			$Trabuc.shoot(power)
			power = 0
			isReady = false
			yield(get_tree().create_timer(2),"timeout")
			create_new_trabuc_rock()
			yield(get_tree().create_timer(1),"timeout")
			isReady = true
	$UI/lb_pow.text = str(floor(power))
	if current_rock: 
		$Camera2D.position.x = current_rock.position.x+150
		print(current_rock.linear_velocity.length())
		if current_rock.linear_velocity.length() < 2: 
			current_rock = null
	else: 
		$Camera2D.position.x = 500

func create_new_trabuc_rock():
	var b = ROCK_SCENE.instance()
	b.position = $Trabuc.position
	add_child(b)
	current_rock = b

func add_enemy(val):
	enemies_counter += val
	update_ui()

func update_ui():
	$UI/lb_fg.text = str(force)+"f\n"+str(angle)+"*"
	$UI/lb_enemies.text = str(enemies_counter)
	if enemies_counter <=0: $UI/lb_end_game.visible = true

