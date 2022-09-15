extends Area2D

var impacts = 0

func _ready():
	connect("body_entered",self,"onBodyEntered")

func onBodyEntered(BODY):
	if impacts>4:return
	if ["Arm","Base","Floor","Rock1","Rock2","Rock3"].find(BODY.name)!=-1: return
	print(BODY.name)
	if !$AudioStreamPlayer2D.playing: $AudioStreamPlayer2D.play()
	impacts += 1
