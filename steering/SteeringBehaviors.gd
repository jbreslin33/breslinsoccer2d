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

func accumalateForce(forceToAdd):
	var magnitudeSoFar = mSteeringForce.length()
	var magnitudeRemaining = mPlayer.mMaxForce - magnitudeSoFar
	
	if (magnitudeRemaining <= 0.0):
		return false
		
	var magnitudeToAdd = forceToAdd.length()
	
	if (magnitudeToAdd > magnitudeRemaining):
		magnitudeToAdd = magnitudeRemaining
		
	var forceToAddNormalized = forceToAdd.normalized()
	forceToAddNormalized = forceToAddNormalized * magnitudeToAdd
	mSteeringForce += forceToAddNormalized
			
	return true

func calculate():
	zeroSteeringForce()
	mSteeringForce = sumForces()

func sumForces():
	var force = Vector2(0,0)
	
	findNeighbors()
	
	if (getSeekOn() == true):
		force += getSeekTargetVelocity(mTarget)
		#if (!AccumulateForce(m_vSteeringForce, force)) return m_vSteeringForce;^M
		if (!accumalateForce(force)):
			return mSteeringForce
		pass
	
	return mSteeringForce
	pass

func getForwardComponent():
	pass

func getSideComponent():
	#return m_pPlayer->Side().Dot(m_vSteeringForce) * m_pPlayer->MaxTurnRate();^
	var x = mPlayer.mHeading.x
	var y = mPlayer.mHeading.y *-1
	mPlayer.mSide.x = x
	mPlayer.mSide.y = y
	
	var mDot = mPlayer.mSide.dot(mSteeringForce)
	var sideComponent = mDot * mPlayer.mMaxTurnRate
	return sideComponent

func zeroSteeringForce():
	mSteeringForce.x = 0;
	mSteeringForce.y = 0;
	

func getSeekTargetVelocity(target):
	var v = Vector2(0,0)
	var desiredVelocity = target - mPlayer.position
	desiredVelocity = desiredVelocity * mPlayer.WALK_SPEED
	#print("x:",desiredVelocity.x, "y:",desiredVelocity.y)
	
	
	var seekTargetVelocity = desiredVelocity - mPlayer.mVelocity
	#print("x:",seekTargetVelocity.x, "y:",seekTargetVelocity.y)
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


