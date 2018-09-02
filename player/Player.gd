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
		print("setHOmePlayer to control")
		mMain.setControllingPlayer(mMain.mHomePlayer1)
	if Input.is_action_pressed("ui_number_2"):
		print("setAwayPlayer to control")
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
		#print("x:", mVelocity.x, "y:",mVelocity.y)		
		if (mVelocity.x == 0  && mVelocity.y < 0):
			mSprite.play("dribble_0")
			mDribblingPosition = 8
						
		elif (mVelocity.x > 0 && mVelocity.y < 0):
			mSprite.play("dribble_45")			
			mDribblingPosition = 9
			
		elif (mVelocity.x > 0 && mVelocity.y == 0):
			mSprite.play("dribble_90")	
			mDribblingPosition = 6
			
		elif (mVelocity.x > 0 && mVelocity.y > 0):
			mSprite.play("dribble_135")	
			mDribblingPosition = 3
			
		elif (mVelocity.x == 0 && mVelocity.y > 0):
			mSprite.play("dribble_180")				
			mDribblingPosition = 2
			
		elif (mVelocity.x < 0 && mVelocity.y > 0):
			mSprite.play("dribble_225")	
			mDribblingPosition = 1
			
		elif (mVelocity.x < 0 && mVelocity.y == 0):
			mSprite.play("dribble_270")	
			mDribblingPosition = 4
			
		elif (mVelocity.x < 0 && mVelocity.y < 0):
			mSprite.play("dribble_315")	
			mDribblingPosition = 7
			
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
	
#call col detection.....

func checkForSteal(myarea,area):
	#print("checking for steal")
	if (mBall.mPlayer == self):
		#print("checking for seal and im the ball carrier")
		if (area.get_name() == "Area2D_180"):
			if (myarea == "Area2D_90"):
				if (mDribblingPosition == 6):
					print("hit area 90 of player with ball with defenders 180")
	pass
	
func _on_Area2D_0_area_entered(area):
	if (area.get_name() == "Area2D_ball"):
		mBall.mPlayer = self
		print("hit:0")
	checkForSteal("Area2D_0",area)

func _on_Area2D_45_area_entered(area):
	if (area.get_name() == "Area2D_ball"):
		print("hit:45")
	checkForSteal("Area2D_45",area)

func _on_Area2D_90_area_entered(area):
	if (area.get_name() == "Area2D_ball"):
		print("hit:90")
	checkForSteal("Area2D_90",area)
		
func _on_Area2D_135_area_entered(area):
	if (area.get_name() == "Area2D_ball"):
		print("hit:135")
	checkForSteal("Area2D_135",area)

func _on_Area2D_180_area_entered(area):
	if (area.get_name() == "Area2D_ball"):
		print("hit:180")
	checkForSteal("Area2D_180",area)

func _on_Area2D_225_area_entered(area):
	if (area.get_name() == "Area2D_ball"):
		print("hit:225")
	checkForSteal("Area2D_225",area)

func _on_Area2D_270_area_entered(area):
	if (area.get_name() == "Area2D_ball"):
		print("hit:270")
	checkForSteal("Area2D_270",area)

func _on_Area2D_315_area_entered(area):
	if (area.get_name() == "Area2D_ball"):
		print("hit:315")
	checkForSteal("Area2D_315",area)

func _on_Area2D_area_entered(area):
	pass # Replace with function body.
