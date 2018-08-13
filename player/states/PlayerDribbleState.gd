extends "res://fsm/State.gd"
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")


func _ready():
	pass

func _enter(player):
	#player.mSteeringBehaviors.setSeekOn(true)
	print("enter drible")
	
	#take control of ball
	print("take control of ball")
	player.mMain.mBall.mPlayer = player
		
func _execute(player):
	#have ball follow player
	
	
	#set target to the ball position
	var goalVector = Vector2(10,360)
	
	player.mSteeringBehaviors.setTarget(goalVector)
	
	#if (player.isWithinShootingRange()):
	#	player.mStateMachine.changeState(player.mPlayerShootState)
	
	pass
	
func _exit(player):
	
	pass


