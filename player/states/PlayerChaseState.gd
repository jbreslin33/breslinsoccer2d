extends "res://fsm/State.gd"
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")

func _ready():
	pass

func _enter(player):
	player.mSteeringBehaviors.setSeekOn(true)
	print("enter chase")
	
func _execute(player):

	#set target		
	player.mSteeringBehaviors.setTarget(player.mMain.mBall.position)

	#check if you have ball if so switch to dribble for now
	if (player.mBall.mPlayer == player):
		player.mStateMachine.changeState(player.mPlayerDribbleState)

	#lets look at the ball we are chasing
	player.lookAtBall()
	
func _exit(player):
	pass


