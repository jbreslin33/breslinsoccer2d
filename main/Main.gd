extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

#team
var Team = load("res://team/team.gd")

var mHomeTeam = 0
var mAwayTeam = 0
var mBall = 0
var mControllerPlayer = 0

const WALK_SPEED = 70

var velocity = Vector2()

func _init():
	
	#teams
	mHomeTeam = Team.new(self)
	mAwayTeam = Team.new(self)
	
	mBall = $Ball

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here.
	
	#ball
	mBall = $Ball
	
	#set players to teams
	$AwayPlayer1.setTeam(mAwayTeam)
	$HomePlayer1.setTeam(mHomeTeam)
	
	#set player main
	$AwayPlayer1.setMain(self)
	$HomePlayer1.setMain(self)
	
	setControllerPlayer($HomePlayer1)
	
	$AwayPlayer1.mStateMachine.changeState($AwayPlayer1.mPlayerChaseState)	
	pass

func setControllerPlayer(player):
	mControllerPlayer = player

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass