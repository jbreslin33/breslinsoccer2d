extends "res://fsm/State.gd"
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")


func _ready():
	pass

func _enter(player):
	player.mSteeringBehaviors.setSeekOn(true)
	print("enter chase")
func _execute(player):
	
	#set target to the ball position
	#var goalVector = Vector2(10,360)
	
	player.mSteeringBehaviors.setTarget(player.mMain.mBall.position)
	
	#check if you collide or are close enough
	if ( abs(player.position.x - player.mMain.mBall.position.x) < 1 && abs(player.position.y - player.mMain.mBall.position.y) < 1):
		#try to get posssession
		player.mMain.mBall.resolveConflict(self)
		
	if (self == player.mMain.mBall.mPlayer):
		player.mStateMachine.changeState(player.mPlayerDribbleState)
	#if (player.isWithinShootingRange()):
	#	player.mStateMachine.changeState(player.mPlayerShootState)
	
	pass
	
func _exit(player):
	
	pass


