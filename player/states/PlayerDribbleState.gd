extends "res://fsm/State.gd"
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")


func _ready():
	pass

func _enter(player):
	print("enter dribble")
	player.mSteeringBehaviors.setSeekOn(true)
	
func _execute(player):
	var goalVector = null
	if (player.mTeam == player.mMain.mHomeTeam):
		goalVector = Vector2(1060,360)
	else:
		goalVector = Vector2(10,360)		
	
	player.mSteeringBehaviors.setTarget(goalVector)	

	pass
func _exit(player):
	
	pass


