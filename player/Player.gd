extends KinematicBody2D

#state machine
var PlayerChaseState = load("res://player/states/PlayerChaseState.gd")
var PlayerDribbleState = load("res://player/states/PlayerDribbleState.gd")
var PlayerShootState = load("res://player/states/PlayerShootState.gd")
var PlayerGoToShootingPositionState = load("res://player/states/PlayerGoToShootingPositionState.gd")
var StateMachine = load("res://fsm/StateMachine.gd")

#steering
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")

var mStateMachine = 0
var mPlayerChaseState = 0
var mPlayerDribbleState = 0
var mPlayerShootState = 0
var mPlayerGoToShootingPositionState = 0

var mSteeringBehaviors = 0

#velocity
var mRunSpeed = 70
var mMaxSpeed = 70

#kick
var mMaxKickForce = 200

var mVelocity = Vector2(0,0)

#rotation
var mHeading = Vector2(0,0)
var mSide = Vector2(0,0)

var mMaxForce = 1.0
var mMaxTurnRate = 0.4

#shooting
var mShootingRange = 2000

#team
var mTeam = null

#main
var mMain = null

#sprite
var mSprite = null

func _init():

	#steering
	mSteeringBehaviors = SteeringBehaviors.new(self)

	#state machine
	mStateMachine = StateMachine.new(self)
	mPlayerChaseState = PlayerChaseState.new()
	mPlayerDribbleState = PlayerDribbleState.new()
	mPlayerShootState = PlayerShootState.new()
	mPlayerGoToShootingPositionState = PlayerGoToShootingPositionState.new()	
	
func _ready():
	mSprite = $Sprite
	mSprite.mPlayer = self
	pass


func _physics_process(delta):
	if (mMain):
		if (mMain.mControllingPlayer == self):
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
	
func isWithinShootingRange():
	var p = position
	var b = mMain.mBall.position
	var d = p.distance_squared_to(b)
	if (d < abs(mShootingRange)):
		return true
	else:
		return false

func getShootingPosition():
	#print("shootingpos")
	var goalVector = Vector2(10,360)
	#return goalVector
	var distanceFromBall = 30
	var distanceAway = distanceFromBall + 5
	var toObject = mMain.mBall.position - goalVector
	var toObjectNormalized = toObject.normalized()
	var scaledSpot = (toObjectNormalized * distanceAway) + mMain.mBall.position
	return scaledSpot
	pass	
	
	
