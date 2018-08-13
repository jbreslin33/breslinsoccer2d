extends "res://fsm/State.gd"
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")


func _ready():
	pass

func _enter(player):
	#player.mSteeringBehaviors.setSeekOn(true)
	print("enter dribble")
	
	#take control of ball
	print("take control of ball")
	player.mMain.mBall.mPlayer = player
		
func _execute(player):
	#have ball follow player
	
	
	#set target to the ball position
	var goalVector = null
	if (player.mTeam == player.mMain.mHomeTeam):
		goalVector = Vector2(1060,360)
	else:
		goalVector = Vector2(10,360)		
	
	player.mSteeringBehaviors.setTarget(goalVector)
	
	if (player.mMain.mBall.mPlayer != player):
		player.mStateMachine.changeState(player.mPlayerChaseState)
	else:
		#add something to dribble
	#if (player.isWithinShootingRange()):
	#	player.mStateMachine.changeState(player.mPlayerShootState)
	
	#dribble to what side...
		pass
	
func _exit(player):
	
	pass


