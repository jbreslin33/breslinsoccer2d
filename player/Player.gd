extends KinematicBody2D

#state machine
var PlayerChaseState = load("res://player/states/PlayerChaseState.gd")
var StateMachine = load("res://fsm/StateMachine.gd")

#steering
var SteeringBehaviors = load("res://steering/SteeringBehaviors.gd")

var mStateMachine = 0
var mPlayerChaseState = 0

var mSteeringBehaviors = 0

const WALK_SPEED = 70

var velocity = Vector2()

func _init():
	
	#steering
	mSteeringBehaviors = SteeringBehaviors.new(self)

	#state machine
	mStateMachine = StateMachine.new(self)
	mPlayerChaseState = PlayerChaseState.new()
	mStateMachine.changeState(mPlayerChaseState)


func _physics_process(delta):
    velocity.y += delta

    if Input.is_action_pressed("ui_left"):
        velocity.x = -WALK_SPEED
    elif Input.is_action_pressed("ui_right"):
        velocity.x =  WALK_SPEED
    else:
        velocity.x = 0
    if Input.is_action_pressed("ui_up"):
        velocity.y = -WALK_SPEED
    elif Input.is_action_pressed("ui_down"):
        velocity.y =  WALK_SPEED
    else:
        velocity.y = 0
    # We don't need to multiply velocity by delta because MoveAndSlide already takes delta time into account.

    # The second parameter of move_and_slide is the normal pointing up.
    # In the case of a 2d platformer, in Godot upward is negative y, which translates to -1 as a normal.
    move_and_slide(velocity, Vector2(0, -1))
