require 'ruby2d'

set width: 500, height: 600

def findDistance(x,y,goal)
	x = x - goal[0]
	y = y - goal[1]
	heur = x.abs+y.abs
	return heur
end

def detColor(h)
	return h*0.03
end

def newSquare(x,y,clr)
	sqr = Square.new
	sqr.x = x*20
	sqr.y = y*20
	sqr.size = 20
	sqr.color = clr
end

def goalCheck(x,y,goal)
	if goal == [x,y]
		return true
	end
	return false
end

def startCheck(x,y,start)
	if start == [x,y]
		return true
	end
	return false
end

def drawTitle()
	rect = Rectangle.new
	rect.x = 0
	rect.y = 0
	rect.width = 500
	rect.height = 100
	rect.color = [0,0,0,1]
	Text.new(
		'ALGORITHM VISUALIZER',
		x: 40, y: 30,
		size: 35,
		color: 'white'
	)
end

def drawSquares()
	i = 0
	j = 5
	goal = [16,9]
	start = [3,25]
	while i <= 30
		while j <= 30
			heur = findDistance(i,j,goal)
			c = detColor(heur)
			clr = [c,c,c,1]
			#clr = [0.5,0.1,c,1]
			newSquare(i,j,clr)
			if goalCheck(i,j,goal)
				clr = [0,0.8,0.2,1]
				newSquare(i,j,clr)
			end
			if startCheck(i,j,start)
				puts "dog"
				clr = [1,0.4,0.3,1]
				newSquare(i,j,clr)
			end
			j += 1
		end
		j = 5
		i += 1
	end
end

on :key_up do |event|
	exit
end

drawTitle()
drawSquares()
show