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

#team
var mTeam = null

#main
var mMain = null

#ball
var mBall = null

#dribbling
var mDribblingPosition = 0
var mDribblingCollisionShape2D = null

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
	if (mMain == null):
		return
	if Input.is_action_pressed("ui_number_1"):
		mMain.setControllingPlayer(mMain.mHomePlayer1)
	if Input.is_action_pressed("ui_number_2"):
		mMain.setControllingPlayer(mMain.mAwayPlayer1)
	
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
	
		if (mSteeringBehaviors.mSteeringForce.x == 0 && mSteeringBehaviors.mSteeringForce.y == 0):
			var breakingRate = 0.8
			mVelocity = mVelocity * breakingRate
			
		#rotation
		var turningForce = mSteeringBehaviors.getSideComponent()
		
		turningForce = clamp(turningForce,-mMaxTurnRate,mMaxTurnRate)

		var v = Vector2(0,0)
		#look_at(mSteeringBehaviors.mTarget)
			
		mVelocity = mSteeringBehaviors.mSteeringForce * mRunSpeed
	
	if (mBall.mPlayer == self):
		if (mVelocity.x == 0  && mVelocity.y < 0):
			mDribblingPosition = 8
			mDribblingCollisionShape2D = $Area2D_0/CollisionShape2D
						
		elif (mVelocity.x > 0 && mVelocity.y < 0):
			mDribblingPosition = 9
			mDribblingCollisionShape2D = $Area2D_45/CollisionShape2D
						
		elif (mVelocity.x > 0 && mVelocity.y == 0):
			mDribblingPosition = 6
			mDribblingCollisionShape2D = $Area2D_90/CollisionShape2D
			
		elif (mVelocity.x > 0 && mVelocity.y > 0):
			mDribblingPosition = 3
			mDribblingCollisionShape2D = $Area2D_135/CollisionShape2D

		elif (mVelocity.x == 0 && mVelocity.y > 0):
			mDribblingPosition = 2
			mDribblingCollisionShape2D = $Area2D_180/CollisionShape2D
			
		elif (mVelocity.x < 0 && mVelocity.y > 0):
			mDribblingPosition = 1
			mDribblingCollisionShape2D = $Area2D_225/CollisionShape2D
			
		elif (mVelocity.x < 0 && mVelocity.y == 0):
			mDribblingPosition = 4
			mDribblingCollisionShape2D = $Area2D_270/CollisionShape2D
		
		elif (mVelocity.x < 0 && mVelocity.y < 0):
			mDribblingPosition = 7
			mDribblingCollisionShape2D = $Area2D_315/CollisionShape2D
			
	else:
		mSprite.play("run")
	
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
	
#on this function area should be opponent trying to steal
func checkForLossOfPossession(myarea,area):
	if (myarea == "Area2D_0" && mDribblingPosition == 8):
		return true
	if (myarea == "Area2D_45" && mDribblingPosition == 9):
		return true
	if (myarea == "Area2D_90" && mDribblingPosition == 6):
		return true
	if (myarea == "Area2D_135" && mDribblingPosition == 3):
		return true		
	if (myarea == "Area2D_180" && mDribblingPosition == 2):
		return true
	if (myarea == "Area2D_225" && mDribblingPosition == 1):
		return true
	if (myarea == "Area2D_270" && mDribblingPosition == 4):
		return true
	if (myarea == "Area2D_315" && mDribblingPosition == 7):
		return true
	return false

func checkForLooseBallPossess(myArea,area):
	if (area.get_name() == "Area2D_ball"):
		mBall.mPlayer = self

func runACheck(myArea,area):
	checkForLooseBallPossess(myArea,area)
	if (mBall.mPlayer == self):
		if (checkForLossOfPossession(myArea,area)):
			mBall.mPlayer = null

func _on_Area2D_0_area_entered(area):
	runACheck("Area2D_0",area)
	
func _on_Area2D_45_area_entered(area):
	runACheck("Area2D_45",area)

func _on_Area2D_90_area_entered(area):
	runACheck("Area2D_90",area)
		
func _on_Area2D_135_area_entered(area):
	runACheck("Area2D_135",area)

func _on_Area2D_180_area_entered(area):
	runACheck("Area2D_180",area)

func _on_Area2D_225_area_entered(area):
	runACheck("Area2D_225",area)

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
	$Area2D_135/CollisionShape2D.disabled = true
	$Area2D_180/CollisionShape2D.disabled = true
	$Area2D_225/CollisionShape2D.disabled = true
	$Area2D_270/CollisionShape2D.disabled = true
	$Area2D_315/CollisionShape2D.disabled = true

func enableFeelerCollisions():
	$Area2D_0/CollisionShape2D.disabled = false
	$Area2D_45/CollisionShape2D.disabled = false
	$Area2D_90/CollisionShape2D.disabled = false
	$Area2D_135/CollisionShape2D.disabled = false
	$Area2D_180/CollisionShape2D.disabled = false
	$Area2D_225/CollisionShape2D.disabled = false
	$Area2D_270/CollisionShape2D.disabled = false
	$Area2D_315/CollisionShape2D.disabled = false	
	
	