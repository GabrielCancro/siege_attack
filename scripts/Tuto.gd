extends Node

var isStoped = false
var read_time = 5
var cFrom =  Color(.7,.7,.7,0)
var cTo = Color(.7,.7,.7,1)

var texts = [
	"Manetené [A] para cargar,\nSoltalo para disparar.",
	"Usá los direccionales para moverte\na la izquierda y derecha.",
	"Asediá el castillo y aplastá\na todos los soldados."
]

func _ready():
	$Label.visible = false
	yield(get_tree().create_timer(2),"timeout")
	if GC.castle_index==0: next_tuto(0)

func next_tuto(index=0):
	if isStoped: return
	if index >= texts.size(): return
	$Label.visible = true
	$Label.modulate = cFrom
	$Label.text = texts[index]
	$Tween.interpolate_property($Label,"modulate",cFrom,cTo,.5,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()
	yield(get_tree().create_timer(read_time),"timeout")
	$Tween.interpolate_property($Label,"modulate",cTo,cFrom,.5,Tween.TRANS_QUAD,Tween.EASE_IN)
	$Tween.start()
	yield(get_tree().create_timer(1),"timeout")
	next_tuto(index+1)
