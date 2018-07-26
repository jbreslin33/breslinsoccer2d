extends Node2D

#touchline coordinates
var northTouchline = 20
var southTouchline = 700
var eastTouchline = 10
var westTouchline = 1060
var centerVector = Vector2(535,360)

func draw_pitch_lines():

	#white line
	var whiteChalk = Color(1.0, 1.0, 1.0)
	
	#tap off circle
	draw_circle(centerVector,5,whiteChalk)
	
	#center circle
	draw_circle_arc(centerVector,95,0,360,whiteChalk)
	
	#midfield line
	var midfieldLineStart = Vector2(centerVector.x,northTouchline)
	var midfieldLineEnd = Vector2(centerVector.x,southTouchline)
	draw_line(midfieldLineStart,midfieldLineEnd,whiteChalk)
	
	#easttouchline
	var eastTouchlineStart = Vector2(eastTouchline,northTouchline)
	var eastTouchlineEnd = Vector2(eastTouchline,southTouchline)
	draw_line(eastTouchlineStart,eastTouchlineEnd,whiteChalk)
	
	#westtouchline
	var westTouchlineStart = Vector2(westTouchline,northTouchline)
	var westTouchlineEnd = Vector2(westTouchline,southTouchline)
	draw_line(westTouchlineStart,westTouchlineEnd,whiteChalk)
	

func draw_circle_arc(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = PoolVector2Array()

    for i in range(nb_points+1):
        var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

    for index_point in range(nb_points):
        draw_line(points_arc[index_point], points_arc[index_point + 1], color)
		
func _draw():
	draw_pitch_lines()