extends Sprite

var playerColor = Color(0,0,0)
var playerPosition = Vector2(0,0)
	
func drawPlayer():
	draw_circle(playerPosition,3,playerColor)

func _draw():
	drawPlayer()
