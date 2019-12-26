require 'ruby2d'

set width: 500, height: 500

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

def specificBlock(x,y,block)
	if block == [x,y]
		return true
	end
	return false
end

def drawSquares()
	i = 0
	j = 0
	goal = [16,9]
	start = [3,22]
	while i <= 25
		while j <= 25
			heur = findDistance(i,j,goal)
			c = detColor(heur)
			clr = [c,c,c,1]
			#clr = [0.5,0.1,c,1]
			newSquare(i,j,clr)
			if specificBlock(i,j,goal)
				clr = [0,0.8,0.2,1]
				newSquare(i,j,clr)
			end
			if specificBlock(i,j,start)
				clr = [1,0.4,0.3,1]
				newSquare(i,j,clr)
			end
			j += 1
		end
		j = 0
		i += 1
	end
end

on :key_up do |event|
	exit
end

drawSquares()
show