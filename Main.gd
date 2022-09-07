extends Node2D

enum EXIT_CODES {
	WIN = 1,
	LOSE = 2,
	QUIT = 0,
}
var ROCKS = {
	"standar": preload("res://blocks/Rock_standar.tscn"),
	"small": preload("res://blocks/Rock_small.tscn"),
}
var rocks_array = ["standar","small","standar","small","standar"]
var enemies_counter = 0
var force = 500
var angle = 45
onready var current_rock = $StartCameraPoint
var current_castle = null
var shadow_rock_1 = null
var shadow_rock_2 = null
var power = 0
var state = "SHOWED" #SHOWING #RELOAD

func _ready():
	randomize()
	InputManager.connect("im_click",self,"onClick")
	$UI/lb_press.visible = false
	$UI/Tween.interpolate_property($UI/Telon,"modulate",$UI/Telon.modulate,Color(1,1,1,0),1,Tween.TRANS_QUAD,Tween.EASE_IN)
	$UI/Tween.start()
	$UI/Telon.visible = true
	create_castle()

func _process(delta):
	if Input.is_action_pressed("escape"): get_tree().quit(EXIT_CODES.WIN);
	if Input.is_action_pressed("right"): $Trabuc.move(+1)
	if Input.is_action_pressed("left"): $Trabuc.move(-1)
	if Input.is_action_pressed("action1") && state=="READY":
		power = min(power+.01,1)
		$Trabuc.set_power(power)
	if Input.is_action_just_released("action1") && state=="READY": 
		$Trabuc.shoot(power)
		power = 0
		state="SHOOTED"
		yield(get_tree().create_timer(2),"timeout")
		state="SHOWED"
		$UI/lb_press.visible = true
	if Input.is_action_just_released("action1") && state=="SHOWED": 
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
	yield(get_tree().create_timer(1),"timeout")
	$UI/Tween.interpolate_property($UI/Telon,"modulate",$UI/Telon.modulate,Color(1,1,1,1),1.5,Tween.TRANS_QUAD,Tween.EASE_IN)
	$UI/Tween.start()
	yield(get_tree().create_timer(2),"timeout")
	if win: get_tree().quit(EXIT_CODES.WIN);
	else: get_tree().quit(EXIT_CODES.LOSE);
	get_tree().reload_current_scene()

func create_castle():
	current_castle = preload("res://castles/Castle.tscn").instance()
	add_child(current_castle)
