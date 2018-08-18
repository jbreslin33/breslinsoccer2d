extends Node2D

var Team = load("res://team/team.gd")

var mHomeTeam = null
var mAwayTeam = null
var mBall = null
var mControllingPlayer = null
    
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
	
	#set player main
	#$AwayPlayer1.setMain(self)
	$HomePlayer1.setMain(self)
	
	#set bal
	#$AwayPlayer1.setBall(mBall)
	$HomePlayer1.setBall(mBall)	
	
	#setControllingPlayer($HomePlayer1)
	
	#$AwayPlayer1.mStateMachine.changeState($AwayPlayer1.mPlayerChaseState)	
	$HomePlayer1.mStateMachine.changeState($HomePlayer1.mPlayerChaseState)	

func setControllingPlayer(player):
	mControllingPlayer = player

