extends KinematicBody2D

var mPlayer = null
var mMain = null
var mPlayerTimedOut = null
var mVelocity = Vector2(0,0)
var mFriction = 0.5
var mHideVector = Vector2(0,0)
var applied = false
#physics
var mInitialVelocity = Vector2(70,0)

func _ready():
	pass
func kick(offset,impulse):
	pass

func _physics_process(delta):
	if (mPlayer == null):
		#show()
		pass
	else:
		#hide()
		pass