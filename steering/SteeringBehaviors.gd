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

func sumForces():
	pass

func forwardComponent():
	pass

func sideComponent():
	pass

func zeroSteeringForce():
	mSteeringForce.x = 0;
	mSteeringForce.y = 0;

func seekTarget(target):
	pass


#set
func setSeekOn(b):
	mSeek = b 


#target
func setTarget(target):
	mTarget = target
	
func getTarget():
	return mTarget


