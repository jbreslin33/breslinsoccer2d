extends Node2D

var Team = load("res://team/team.gd")

var mHomeTeam = null
var mAwayTeam = null
var mBall = null
var mControllingPlayer = null
var mHomePlayer1 = null
var mAwayPlayer1 = null
    
func _init():
	
	#teams
	mHomeTeam = Team.new(self)
	mAwayTeam = Team.new(self)

func _ready():
	
	#ball
	mBall = $Ball
	mBall.mMain = self
		
	#set players to teams
	#$AwayPlayer1.setTeam(mAwayTeam)
	$HomePlayer1.setTeam(mHomeTeam)
	$AwayPlayer1.setTeam(mAwayTeam)
	
	#set player main
	#$AwayPlayer1.setMain(self)
	$HomePlayer1.setMain(self)
	$AwayPlayer1.setMain(self)
	
	#set bal
	#$AwayPlayer1.setBall(mBall)
	$HomePlayer1.setBall(mBall)
	$AwayPlayer1.setBall(mBall)	
	
	setControllingPlayer($HomePlayer1)
	
	mHomePlayer1 = $HomePlayer1
	mAwayPlayer1 = $AwayPlayer1
	
	$AwayPlayer1.mStateMachine.changeState($AwayPlayer1.mPlayerChaseState)	
	#$HomePlayer1.mStateMachine.changeState($HomePlayer1.mPlayerChaseState)	

	#attacking goals
	mHomeTeam.mAttackingGoalVector2 = $Pitch.centerOfEastGoal
	mAwayTeam.mAttackingGoalVector2 = $Pitch.centerOfWestGoal
	
	#defending goals
	mHomeTeam.mDefendingGoalVector2 = $Pitch.centerOfWestGoal
	mAwayTeam.mDefendingGoalVector2 = $Pitch.centerOfEastGoal
		
	
func setControllingPlayer(player):
	mControllingPlayer = player

