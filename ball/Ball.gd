extends KinematicBody2D

var mPlayer = null
var mMain = null
var mPlayerTimedOut = null
var mVelocity = Vector2(0,0)
var mFriction = 0.99
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
		$CollisionShape2D.disabled = false
		pass
	else:
		if (mPlayer.mDribblingCollisionShape2D != null):
			$CollisionShape2D.disabled = true
			var v = Vector2(mPlayer.mDribblingCollisionShape2D.global_position.x,mPlayer.mDribblingCollisionShape2D.global_position.y)
			set_position(v)
			
	mVelocity = mVelocity * mFriction
	move_and_slide(mVelocity, Vector2(0, -1))
		

