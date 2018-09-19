extends KinematicBody2D

onready var mSprite = get_node("AnimatedSprite")

#state machine
var StateMachine = load("res://fsm/StateMachine.gd")

#states
var PlayerChaseState = load("res://player/states/PlayerChaseState.gd")
var PlayerDribbleState = load("res://player/states/PlayerDribbleState.gd")

#steering
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")

#state machine
var mStateMachine = null

#states
var mPlayerChaseState = null
var mPlayerDribbleState = null

#steering
var mSteeringBehaviors = null

#velocity
var mRunSpeed = 70

var mVelocity = Vector2(0,0)

#rotation
var mHeading = Vector2(0,0)
var mSide = Vector2(0,0)
var mMaxForce = 1.0
var mMaxTurnRate = 0.4

#shooting
var mShootingRange = 2000

var mKickForce = 210

#team
var mTeam = null

#main
var mMain = null

#ball
var mBall = null

#dribbling
var mDribblingPosition = 0
var mDribblingCollisionShape2D = null

var mCollisionTimeoutThreshold = 100
var mCollisionTimeoutCounter = 0
var mCollisionTimeout = false

func _init():

	#state machine
	mStateMachine = StateMachine.new(self)
	
	#states
	mPlayerChaseState = PlayerChaseState.new()
	mPlayerDribbleState = PlayerDribbleState.new()

	#steering
	mSteeringBehaviors = SteeringBehaviors.new(self)	
	
func _ready():

	pass

func _physics_process(delta):
	# if its too early get out
	if (mMain == null):
		return
	#swith players
	if Input.is_action_pressed("ui_number_1"):
		mMain.setControllingPlayer(mMain.mHomePlayer1)
	if Input.is_action_pressed("ui_number_2"):
		mMain.setControllingPlayer(mMain.mAwayPlayer1)

	#shoot code
	if Input.is_action_pressed("shoot"):
		if (mBall.mPlayer == self):
			mBall.mPlayer = null
			print("shoot")
			mBall.mVelocity = Vector2(100,0)
			mBall.mVelocity = mBall.mVelocity.normalized()
			mBall.mVelocity = mBall.mVelocity * mKickForce
			print(mBall.mVelocity)
	
	#translation movement for user controlled 
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
	#ai
	else:
		mStateMachine.update()
		mSteeringBehaviors.calculate()
	
		if (mSteeringBehaviors.mSteeringForce.x == 0 && mSteeringBehaviors.mSteeringForce.y == 0):
			var breakingRate = 0.8
			mVelocity = mVelocity * breakingRate
			
		#rotation
		var turningForce = mSteeringBehaviors.getSideComponent()
		
		turningForce = clamp(turningForce,-mMaxTurnRate,mMaxTurnRate)

		var v = Vector2(0,0)
		#look_at(mSteeringBehaviors.mTarget)
			
		mVelocity = mSteeringBehaviors.mSteeringForce * mRunSpeed
	
	#player with ball
	if (mBall.mPlayer == self):
			#lets just always be at 0 degrees for now until we build more ai to protect bal
			mDribblingPosition = 0
			mDribblingCollisionShape2D = $Area2D_0/CollisionShape2D
		    #print("dp:",mDribblingPosition)
	#player without ball
	else:
		mSprite.play("run")
		
	#FEELERS
	if (mBall.mPlayer == self):
		disableFeelerCollisions()
	else:
		if (mCollisionTimeout == true):
			mCollisionTimeoutCounter = mCollisionTimeoutCounter + 1
			if (mCollisionTimeoutCounter > mCollisionTimeoutThreshold):
				enableFeelerCollisions()
		else:
			enableFeelerCollisions()

	#rotate
	#if (mBall.mPlayer != self):
	#	var p = Vector2(mBall.global_position.x,mBall.global_position.y)
	#	look_at(p)

	move_and_slide(mVelocity, Vector2(0, -1))
	
func setTeam(team):
	mTeam = team

func setMain(main):
	mMain = main
	
func setBall(ball):
	mBall = ball
	
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

#POSSESSION	

func checkForBallPossess(myArea,area):
	#was the area your myArea entered the ball area?
	if (area.get_name() == "Area2D_ball"):
		#if so make ball carrier if there is one have a timeout
		if (mBall.mPlayer):
			mBall.mPlayer.mCollisionTimeout = true
		#make yourself the ball carrier
		mBall.mPlayer = self
	
func runACheck(myArea,area):
	checkForBallPossess(myArea,area)


func _on_Area2D_0_area_entered(area):
	runACheck("Area2D_0",area)
	
func _on_Area2D_45_area_entered(area):
	runACheck("Area2D_45",area)

func _on_Area2D_90_area_entered(area):
	runACheck("Area2D_90",area)
		
func _on_Area2D_270_area_entered(area):
	runACheck("Area2D_270",area)

func _on_Area2D_315_area_entered(area):
	runACheck("Area2D_315",area)

func _on_Area2D_area_entered(area):
	pass # Replace with function body.

func disableFeelerCollisions():
	$Area2D_0/CollisionShape2D.disabled = true
	$Area2D_45/CollisionShape2D.disabled = true
	$Area2D_90/CollisionShape2D.disabled = true
	$Area2D_270/CollisionShape2D.disabled = true
	$Area2D_315/CollisionShape2D.disabled = true

func enableFeelerCollisions():
	$Area2D_0/CollisionShape2D.disabled = false
	$Area2D_45/CollisionShape2D.disabled = false
	$Area2D_90/CollisionShape2D.disabled = false
	$Area2D_270/CollisionShape2D.disabled = false
	$Area2D_315/CollisionShape2D.disabled = false	
	
	