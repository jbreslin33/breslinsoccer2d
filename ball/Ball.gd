extends RigidBody2D

var mPlayer = null
var mMain = null
var mPlayerTimedOut = null
var mVelocity = Vector2(0,0)
var mFriction = 0.05
var mHideVector = Vector2(0,0)

#physics
var mInitialVelocity = Vector2(0,0)

func _ready():
	set_gravity_scale(0)

func kick(offset,impulse):
	pass

func _physics_process(delta):
	if (mPlayer == null):
		show()
	else:
		hide()


