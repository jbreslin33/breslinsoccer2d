extends KinematicBody2D

#state machine
var PlayerChaseState = load("res://player/states/PlayerChaseState.gd")
var StateMachine = load("res://fsm/StateMachine.gd")

#steering
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")

var mStateMachine = 0
var mPlayerChaseState = 0

var mSteeringBehaviors = 0

const WALK_SPEED = 70

var mVelocity = Vector2(0,0)

var mMaxForce = 1.0

#team
var mTeam = 0

#main
var mMain = 0

func _init():

	#steering
	mSteeringBehaviors = SteeringBehaviors.new(self)

	#state machine
	mStateMachine = StateMachine.new(self)
	mPlayerChaseState = PlayerChaseState.new()
	
func _ready():
	pass


func _physics_process(delta):

	if (mMain.mControllerPlayer == self):
		if Input.is_action_pressed("ui_left"):
			mVelocity.x = -WALK_SPEED
		elif Input.is_action_pressed("ui_right"):
			mVelocity.x =  WALK_SPEED
		else:
			mVelocity.x = 0
		if Input.is_action_pressed("ui_up"):
			mVelocity.y = -WALK_SPEED
		elif Input.is_action_pressed("ui_down"):
			mVelocity.y =  WALK_SPEED
		else:
			mVelocity.y = 0
	else:
		#ai
		mStateMachine.update()
		mSteeringBehaviors.calculate()

		#brake
		print("x:",mSteeringBehaviors.mSteeringForce.x)
		if (mSteeringBehaviors.mSteeringForce.x == 0 && mSteeringBehaviors.mSteeringForce.y == 0):
			var breakingRate = 0.8
			mVelocity = mVelocity * breakingRate
			
			var turningForce = mSteeringBehaviors.getSideComponent()

	move_and_slide(mVelocity, Vector2(0, -1))
	
func setTeam(team):
	mTeam = team

func setMain(main):
	mMain = main
	
