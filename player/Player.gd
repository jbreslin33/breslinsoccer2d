extends KinematicBody2D

#state machine
var PlayerChaseState = load("res://player/states/PlayerChaseState.gd")
var StateMachine = load("res://fsm/StateMachine.gd")

#steering
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")

var mStateMachine = 0
var mPlayerChaseState = 0

var mSteeringBehaviors = 0

var mRunSpeed = 70
var mMaxSpeed = 70

var mVelocity = Vector2(0,0)
var mHeading = Vector2(0,0)
var mSide = Vector2(0,0)

var mMaxForce = 1.0
var mMaxTurnRate = 0.4


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
	if (mMain):
		if (mMain.mControllerPlayer == self):
			if Input.is_action_pressed("ui_left"):
				mVelocity.x = -mRunSpeed
			elif Input.is_action_pressed("ui_right"):
				mVelocity.x =  mRunSpeed
			else:
				mVelocity.x = 0
			if Input.is_action_pressed("ui_up"):
				mVelocity.y = -mRunSpeed
			elif Input.is_action_pressed("ui_down"):
				mVelocity.y =  mRunSpeed
			else:
				mVelocity.y = 0
		else:
			#ai
			mStateMachine.update()
			mSteeringBehaviors.calculate()
			
			#print(mSteeringBehaviors.mSteeringForce)

			#brake
			#print("x:",mSteeringBehaviors.mSteeringForce.x)
			if (mSteeringBehaviors.mSteeringForce.x == 0 && mSteeringBehaviors.mSteeringForce.y == 0):
				var breakingRate = 0.8
				mVelocity = mVelocity * breakingRate
			
			#rotation
			var turningForce = mSteeringBehaviors.getSideComponent()
			#print(turningForce)

			#Clamp(TurningForce, -Prm.PlayerMaxTurnRate, Prm.PlayerMaxTurnRate);
			turningForce = clamp(turningForce,-mMaxTurnRate,mMaxTurnRate)
			#print(turningForce)
			var v = Vector2(0,0)
			look_at(mSteeringBehaviors.mTarget)
			#look_at(v)
			
			mVelocity = mSteeringBehaviors.mSteeringForce * mRunSpeed
		
		
		
		move_and_slide(mVelocity, Vector2(0, -1))
	
func setTeam(team):
	mTeam = team

func setMain(main):
	mMain = main
	
