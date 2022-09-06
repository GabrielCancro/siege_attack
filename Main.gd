extends Node2D

var ROCK_SCENE = preload("res://blocks/Rock1.tscn")
var enemies_counter = 0
var force = 500
var angle = 45
var current_rock = null
var shadow_rock_1 = null
var shadow_rock_2 = null
var power = 0
var state = "READY" #SHOWING #RELOAD

func _ready():
	randomize()
	InputManager.connect("im_click",self,"onClick")
	$Trabuc.connect("on_reload",self,"create_new_trabuc_rock")
	$UI/lb_press.visible = false
	create_new_trabuc_rock()

func _process(delta):
	if Input.is_action_pressed("ui_right"): $Trabuc.move(+1)
	if Input.is_action_pressed("ui_left"): $Trabuc.move(-1)
	if Input.is_action_pressed("ui_accept") && state=="READY":
		power = min(power+.01,1)
		$Trabuc.set_power(power)
	if Input.is_action_just_released("ui_accept") && state=="READY": 
		$Trabuc.shoot(power)
		power = 0
		state="SHOOTED"
		yield(get_tree().create_timer(2),"timeout")
		state="SHOWED"
		$UI/lb_press.visible = true
	if Input.is_action_just_released("ui_accept") && state=="SHOWED": 
		state="READY"
		$Trabuc.set_power(0)
		create_new_trabuc_rock()
		$UI/lb_press.visible = false
	$UI/lb_state.text = state
	if state=="READY": $Camera2D.position.x = $Trabuc.position.x + 200
	else: $Camera2D.position.x = current_rock.position.x+150

func create_new_trabuc_rock():
	var b = ROCK_SCENE.instance()
	b.position = $Trabuc/Arm/ReloadPoint.global_position
	add_child(b)
	current_rock = b

func add_enemy(val):
	enemies_counter += val
	$UI/lb_enemies.text = str(enemies_counter)


