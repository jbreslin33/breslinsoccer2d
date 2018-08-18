extends RigidBody2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var mPlayer = null
var mMain = null
var mPlayerTimedOut = null
var mVelocity = Vector2(0,0)
var mFriction = 0.05
var mHideVector = Vector2(0,0)
#physics
var mInitialVelocity = Vector2(0,0)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_gravity_scale(0)
	pass # Replace with function body.

func kick(offset,impulse):
	pass

func _physics_process(delta):
	if (mPlayer == null):
		show()
	else:
		hide()
	pass

