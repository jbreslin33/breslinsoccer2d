extends "res://fsm/State.gd"
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")


func _ready():
	pass

func _enter(player):
	player.mSteeringBehaviors.setSeekOn(true)
	
func _execute(player):
	
	#set target to the ball position
	player.mSteeringBehaviors.setTarget(player.mMain.mBall.position)
	#print("x:",player.mSteeringBehaviors.getTarget().x,"y:",player.mSteeringBehaviors.getTarget().y)
	
	
	pass
	
func _exit(player):
	
	pass
