extends Node2D

#touchline coordinates
var northTouchline = 20
var southTouchline = 700
var eastTouchline = 10
var westTouchline = 1060
var centerVector = Vector2(535,360)
var centerOfEastGoal = Vector2(10,360)
var centerOfWestGoal = Vector2(1060,360)

#colors
var whiteChalk = Color(1.0, 1.0, 1.0)
var redChalk = Color(1.0, 0, 0)
var greenGrass = Color(.1,0.5,0)

func drawGrass():
	var grassSizeVector = get_viewport().get_size_override()
	var grassPositionVector = Vector2(0,0)
	var grassRect2 = Rect2(grassPositionVector,grassSizeVector)
	draw_rect(grassRect2,greenGrass,true)

func drawTapOffCircle():
	draw_circle(centerVector,5,whiteChalk)

func drawCenterCircle():
	draw_circle_arc(centerVector,95,0,360,whiteChalk)

func drawMidFieldLine():
	var start = Vector2(centerVector.x,northTouchline)
	var end = Vector2(centerVector.x,southTouchline)
	draw_line(start,end,whiteChalk)	

func drawEastTouchline():
	var start = Vector2(eastTouchline,northTouchline)
	var end = Vector2(eastTouchline,southTouchline)
	draw_line(start,end,whiteChalk)

func drawWestTouchline():
	var start = Vector2(westTouchline,northTouchline)
	var end = Vector2(westTouchline,southTouchline)
	draw_line(start,end,whiteChalk)
	
func drawNorthTouchline():
	var start = Vector2(eastTouchline,northTouchline)
	var end = Vector2(westTouchline,northTouchline)
	draw_line(start,end,whiteChalk)

func drawSouthTouchline():
	var start = Vector2(eastTouchline,southTouchline)
	var end = Vector2(westTouchline,southTouchline)
	draw_line(start,end,whiteChalk)

func drawPenaltyBoxEast():
	var start = Vector2(eastTouchline + 165, centerVector.y - 36.6 - 165)
	var end = Vector2(eastTouchline + 165, centerVector.y + 36.6 + 165)
	draw_line(start,end,whiteChalk)
	
	start = Vector2(eastTouchline, centerVector.y - 36.6 - 165)
	end = Vector2(eastTouchline + 165, centerVector.y - 36.6 - 165)
	draw_line(start,end,whiteChalk)
	
	start = Vector2(eastTouchline, centerVector.y + 36.6 + 165)
	end = Vector2(eastTouchline + 165, centerVector.y + 36.6 + 165)
	draw_line(start,end,whiteChalk)
	
func drawPenaltyBoxWest():
	var start = Vector2(westTouchline - 165, centerVector.y - 36.6 - 165)
	var end = Vector2(westTouchline - 165, centerVector.y + 36.6 + 165)
	draw_line(start,end,whiteChalk)
	
	start = Vector2(westTouchline, centerVector.y - 36.6 - 165)
	end = Vector2(westTouchline - 165, centerVector.y - 36.6 - 165)
	draw_line(start,end,whiteChalk)
	
	start = Vector2(westTouchline, centerVector.y + 36.6 + 165)
	end = Vector2(westTouchline - 165, centerVector.y + 36.6 + 165)
	draw_line(start,end,whiteChalk)
	
func drawGoalEast():
	var start = Vector2(eastTouchline,centerVector.y - 36.6)
	var end   = Vector2(eastTouchline,centerVector.y + 36.6)
	draw_line(start,end,redChalk)
	
	
func drawGoalWest():
	var start = Vector2(westTouchline,centerVector.y - 36.6)
	var end   = Vector2(westTouchline,centerVector.y + 36.6)
	draw_line(start,end,redChalk)

func draw_circle_arc(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = PoolVector2Array()

    for i in range(nb_points+1):
        var angle_point = deg2rad(angle_from + i * (angle_to-angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)

    for index_point in range(nb_points):
        draw_line(points_arc[index_point], points_arc[index_point + 1], color)
		
func _draw():
	drawGrass()
	
	drawTapOffCircle()
	drawCenterCircle()
	drawMidFieldLine()
	drawEastTouchline()
	drawWestTouchline()
	drawNorthTouchline()
	drawSouthTouchline()
	drawPenaltyBoxEast()
	drawPenaltyBoxWest()
	
	drawGoalEast()
	drawGoalWest()