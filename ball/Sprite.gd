extends Sprite

var ballColor = Color(0,0,0)
var ballPosition = Vector2(0,0)
	
func drawBall():
	draw_circle(ballPosition,3,ballColor)

func _draw():
	drawBall()
