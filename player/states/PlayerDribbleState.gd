extends "res://fsm/State.gd"
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")


func _ready():
	pass

func _enter(player):
	#player.mSteeringBehaviors.setSeekOn(true)
	print("enter dribble")
	
	player.mMain.mPlayerInPossession = player
	
	#take control of ball
	print("take control of ball")
	player.mMain.mBall.mPlayer = player
	
	var goalVector = null
	if (player.mTeam == player.mMain.mHomeTeam):
		goalVector = Vector2(1060,360)
	else:
		goalVector = Vector2(10,360)		
	
	player.mSteeringBehaviors.setTarget(goalVector)
	
	
	#also lets kick ball to goal
	
	player.mMain.mBall.kick(player.position,goalVector.normalized())
	
	#hide the real ball
	player.mMain.mBall.hide()
		
func _execute(player):
	

	#have ball follow player
	
	#kick ball to goal
	#player.mMain.mBall.kick(player.mVelocity * 10)
	
	#head to goal
	#var goalVector = null
	#if (player.mTeam == player.mMain.mHomeTeam):
	#	goalVector = Vector2(1060,360)
	#else:
	#	goalVector = Vector2(10,360)		
	
	#player.mSteeringBehaviors.setTarget(goalVector)
	
	
	#also lets kick ball to goal
	
	#player.mMain.mBall.kick(player.position,goalVector.normalized())
	
	
	#if (player.mMain.mBall.mPlayer != player):
	#	player.mStateMachine.changeState(player.mPlayerChaseState)
	#else:
		#add something to dribble
	#if (player.isWithinShootingRange()):
	#	player.mStateMachine.changeState(player.mPlayerShootState)
	
	#dribble to what side...
	#	pass
	pass
func _exit(player):
	
	pass


