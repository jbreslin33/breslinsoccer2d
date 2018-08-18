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

	#check if you got the ball if so dribble
	if (player.mBall.mPlayer == player):
		player.mStateMachine.changeState(player.mPlayerDribbleState)

	pass
	
func _exit(player):
	
	pass


