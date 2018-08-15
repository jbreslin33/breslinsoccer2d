extends Sprite

var playerColor = Color(0,0,1)
var playerPosition = Vector2(0,0)

func drawPlayer():
	draw_circle(playerPosition,50,playerColor)

func _draw():
	drawPlayer()
