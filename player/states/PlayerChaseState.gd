extends "res://fsm/State.gd"
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")


func _ready():
	pass

func _enter(player):
	player.mSteeringBehaviors.setSeekOn(true)
	print("PlayerChaseState:_enter")
	#player.isBallWithingKickingRange()
	#if (player.mMain):
	#	player.mSteeringBehaviors.setTarget(player.mMain.mPlayerArray[1])
	player.mSteeringBehaviors.setTarget(player.mMain.mBall.position)
	print("x:",player.mSteeringBehaviors.getTarget().x,"y:",player.mSteeringBehaviors.getTarget().y)
	
func _execute(player):
	pass
	
func _exit(player):
	
	pass
