extends Sprite

var playerColor = Color(0,0,1)

func drawPlayer():
	var playerPosition = Vector2(0,0)
	draw_circle(playerPosition,5,playerColor)

func _draw():
	drawPlayer()
