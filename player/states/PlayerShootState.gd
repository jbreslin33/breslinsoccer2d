extends "res://fsm/State.gd"
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")


func _ready():
	pass

func _enter(player):
	#player.mSteeringBehaviors.setSeekOn(true)
	print("enter shoot state")
	#line up for shot
	
	#var target = 
	#var direction = Vector2(0,-400)
	#var n = direction.normalized()
	#player.mMain.mBall.kick(player.position,n)
func _execute(player):
	
	#player.mSteeringBehaviors.setTarget(player.mMain.mBall.position)

	#var start = Vector2(westTouchline,centerVector.y - 36.6)
	#var end   = Vector2(westTouchline,centerVector.y + 36.6)
	#draw_line(start,end,redChalk)
	
	pass
	
func _exit(player):
	
	pass
