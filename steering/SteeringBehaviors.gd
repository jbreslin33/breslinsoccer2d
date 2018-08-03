extends Object

var mPlayer = 0
var mBall = 0
var mSteeringForce = Vector2(0,0) 
var mTarget = Vector2(0,0)

var mInterposeDistance = 0
var mMultSeparation = 0

var mSeek = false 
var mArrive = false 
var mSeparation = false 
var mPursuit = false
var mInterpose = false

var mTagged = false

var mDeceleration = 1

func _init(player):
        mPlayer = player

func accumalateForce(steeringForce,forceToAdd):
	pass

func calculate():
	zeroSteeringForce()
	mSteeringForce = sumForces()

func sumForces():
	var force = Vector2(0,0)
	
	findNeighbors()
	
	if (getSeekOn() == true):
		force += getSeekTargetVelocity(mTarget)
		pass
	
	return mSteeringForce
	pass

func forwardComponent():
	pass

func sideComponent():
	pass

func zeroSteeringForce():
	mSteeringForce.x = 0;
	mSteeringForce.y = 0;
	

func getSeekTargetVelocity(target):
	var v = Vector2(0,0)
	var desiredVelocity = target - mPlayer.position
	desiredVelocity = desiredVelocity * mPlayer.WALK_SPEED
	print("x:",desiredVelocity.x, "y:",desiredVelocity.y)
	
	
	var seekTargetVelocity = desiredVelocity - mPlayer.mVelocity
	
	return seekTargetVelocity
	
	pass


#set
func setSeekOn(b):
	mSeek = b 

#get
func getSeekOn():
	return mSeek

#target
func setTarget(target):
	mTarget = target
	
func getTarget():
	return mTarget
	

func findNeighbors():
	pass


