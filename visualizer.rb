require 'ruby2d'

set width: 500, height: 500

def findDistance(x,y,coord)
	x = x - coord[0]
	y = y - coord[1]
	heur = x.abs+y.abs
	return heur
end

def findMinScore(arr,score)
	arr.sort! { |a,b| a.score <=> b.score}
	return opened[0]
end

def getScores(crnt,goal,start,move)
	g = findDistance(crnt[0],crnt[1],start) + move[0] + move[1]
	h = findDistance(crnt[0],crnt[1],goal)
	f = g + h
	return [f,g,h]
end

def newNode(coord,start,goal,move)
	arr = getScores(coord, goal, start, 0)
	return Node.new(coord,arr[0],arr[1],arr[2])
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

class Node
	def initialize(coord, g_score, h_score, f_score)
		@coord = coord
		@g = g_score
		@h = h_score
		@f = f_score
	end
	def coord
		@coord
	end
	def f_score
		@f
	end
	def h_score
		@h
	end
	def g_score
		@g
	end
end

def aStar()
	opened = []
	closed = []
	goal = [16,9]
	start = [3,22]
	s = newNode(start,start,goal,0)
	opened.push(s)
	#while opened.length > 0
		#min = findMinScore(opened,f_score)
	#end
end

on :key_up do |event|
	exit
end

aStar()
drawSquares()
show