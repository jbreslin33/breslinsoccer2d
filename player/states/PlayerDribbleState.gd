extends "res://fsm/State.gd"
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")


func _ready():
	pass

func _enter(player):
	print("enter dribble")
	player.mSteeringBehaviors.setSeekOn(true)
	
func _execute(player):

	#move towards attacking goal
	player.mSteeringBehaviors.setTarget(player.mTeam.mAttackingGoalVector2)

	#look at attacking goal
	player.lookAtAttackingGoal()
	
func _exit(player):
	
	pass


