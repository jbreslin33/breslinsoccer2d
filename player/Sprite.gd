extends Sprite

var mPlayer = null

var playerColor = Color(0,0,1)
var playerPosition = Vector2(0,0)

var ballColor = Color(0,0,0)
var ballPosition = Vector2(0,0)

func drawPlayer():
	draw_circle(playerPosition,30,playerColor)

func _draw():
	drawPlayer()
	print("p:",mPlayer.mMaxSpeed)
	if (mPlayer):
		if (mPlayer.mMain):
			if (mPlayer.mMain.mPlayerInPossession):
				print("po",mPlayer.mMain.mPlayerInPossession.mMaxSpeed)
	if (mPlayer.mMain.mPlayerInPossession == mPlayer):

		print("dawBalls")
		drawBall()


func drawBall():
	draw_circle(ballPosition,3,ballColor)
	
	pass