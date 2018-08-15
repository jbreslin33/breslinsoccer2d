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


func drawBall():
	draw_circle(ballPosition,3,ballColor)
	
	pass