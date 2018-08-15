extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mPlayer = null
var mMain = null
var mPlayerTimedOut = null
var mVelocity = Vector2(0,0)
var mFriction = 0.05

#physics
var mInitialVelocity = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_gravity_scale(0)
	pass # Replace with function body.

func kick(offset,impulse):
	#mInitialVelocity = initialVelocity
	#Velocity = mInitialVelocity
	#apply_impulse(offset,impulse)
	apply_central_impulse(impulse)
	pass

func _physics_process(delta):
	#if (mPlayer):
	#	mVelocity = (mPlayer.mVelocity * mPlayerDribbleBoost) * friction
		#print(mVelocity.x)
	mVelocity = mVelocity * mFriction
	#move_and_slide(mVelocity, Vector2(0, -1))
	
	if (mPlayer != null):
		var v = Vector2(0,0)
		set_position(v)

