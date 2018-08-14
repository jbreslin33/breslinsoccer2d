extends KinematicBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mPlayer = null
var mPlayerTimedOut = null
var mVelocity = Vector2(0,0)
var mFriction = 0.05

#physics
var mInitialVelocity = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func kick(initialVelocity):
	mInitialVelocity = initialVelocity
	mVelocity = mInitialVelocity
	pass

func _physics_process(delta):
	#if (mPlayer):
	#	mVelocity = (mPlayer.mVelocity * mPlayerDribbleBoost) * friction
		#print(mVelocity.x)
	mVelocity = mVelocity * mFriction
	move_and_slide(mVelocity, Vector2(0, -1))

func resolveConflict(player):
	if (player == mPlayer):
		# do nothing you already have ball
		pass
	else:
		#stop ball
		mPlayer = player
		
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
