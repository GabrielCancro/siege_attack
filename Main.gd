extends Node2D

var ROCKS = {
	"standar": preload("res://blocks/Rock_standar.tscn"),
	"small": preload("res://blocks/Rock_small.tscn"),
}
var rocks_array = ["standar","small","standar","small","standar"]
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
	$UI/Tween.interpolate_property($UI/Telon,"modulate",$UI/Telon.modulate,Color(1,1,1,0),1,Tween.TRANS_QUAD,Tween.EASE_IN)
	$UI/Tween.start()
	$UI/Telon.visible = true

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
	elif current_rock: $Camera2D.position.x = current_rock.position.x+150

func create_new_trabuc_rock():
	if enemies_counter<=0: endGame(true)
	elif rocks_array.size()==0: endGame(false)
	var next_rock = rocks_array.pop_front()
	$UI/lb_shoots.text = str(rocks_array.size())
	current_rock = null
	if next_rock=="standar":
		var b = ROCKS.standar.instance()
		b.position = $Trabuc/Arm/ReloadPoint.global_position
		add_child(b)
		current_rock = b
	if next_rock=="small":
		var b = ROCKS.small.instance()
		b.position = $Trabuc/Arm/ReloadPoint.global_position - Vector2(0,0)
		add_child(b)
		b = ROCKS.small.instance()
		b.position = $Trabuc/Arm/ReloadPoint.global_position - Vector2(-5,-5)
		add_child(b)
		b = ROCKS.small.instance()
		b.position = $Trabuc/Arm/ReloadPoint.global_position - Vector2(5,-5)
		add_child(b)
		current_rock = b

func add_enemy(val):
	enemies_counter += val
	$UI/lb_enemies.text = str(enemies_counter)
	if enemies_counter<=0: endGame(true)

func endGame(win=false):
	set_process(false)
	if win: 
		$UI/lb_end_game.text = "HAS GANADO!!"
		$UI/lb_end_game.modulate = Color(1,1,.5,1)
	else:
		$UI/lb_end_game.text = "PERDISTE!!"
		$UI/lb_end_game.modulate = Color(1,.5,.5,1)
	$UI/lb_end_game.visible = true
	yield(get_tree().create_timer(2),"timeout")
	$UI/Tween.interpolate_property($UI/Telon,"modulate",$UI/Telon.modulate,Color(1,1,1,1),3,Tween.TRANS_QUAD,Tween.EASE_IN)
	$UI/Tween.start()
	yield(get_tree().create_timer(3),"timeout")
	get_tree().reload_current_scene()

