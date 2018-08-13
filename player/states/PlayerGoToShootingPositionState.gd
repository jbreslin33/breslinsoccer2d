extends "res://fsm/State.gd"
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")


func _ready():
	pass

func _enter(player):
	player.mSteeringBehaviors.setSeekOn(true)
	
func _execute(player):
	
	#set target to the ball position
	var goalVector = Vector2(10,360)
	#player.mSteeringBehaviors.setTarget(player.mMain.mBall.position)
	player.mSteeringBehaviors.setTarget(goalVector)
	#print("x:",player.mSteeringBehaviors.getTarget().x,"y:",player.mSteeringBehaviors.getTarget().y)
	
	if (player.isWithinShootingRange()):
		player.mStateMachine.changeState(player.mPlayerShootState)
		#print("shoot")
	
	pass
	
func _exit(player):
	
	pass


