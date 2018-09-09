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
		$Area2D_ball/CollisionShape2D.disabled = false
		#show()
		#var v = Vector2(30,30)
		#set_position(v)
		pass
	else:
		#hide()
		$Area2D_ball/CollisionShape2D.disabled = true
		#lets move ball to col shape
		#print("x:",mPlayer.mDribblingCollisionShape2D.global_position.x);
		if (mPlayer.mDribblingCollisionShape2D != null):
			var v = Vector2(mPlayer.mDribblingCollisionShape2D.global_position.x,mPlayer.mDribblingCollisionShape2D.global_position.y)
			set_position(v)
		

