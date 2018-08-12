extends "res://fsm/State.gd"
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")


func _ready():
	pass

func _enter(player):
	#player.mSteeringBehaviors.setSeekOn(true)
	print("enter shoot state")
func _execute(player):
	
	#player.mSteeringBehaviors.setTarget(player.mMain.mBall.position)

	
	
	pass
	
func _exit(player):
	
	pass
