require 'ruby2d'

set width: 500, height: 500
$border = []

def findDistance(x,y,coord)
	x = x - coord[0]
	y = y - coord[1]
	heur = x.abs+y.abs
	return heur
end

def findMinScore(arr)
	arr.sort! { |a,b| a.h_score <=> b.h_score}
	return arr[0]
end

def getScores(crnt,goal,start,move)
	g = findDistance(crnt[0],crnt[1],start) + move[0] + move[1]
	h = findDistance(crnt[0],crnt[1],goal)
	f = g + h
	return [g,h,f]
end

def newCoord(coord,move)
	result = []
	result[0] = coord[0] + move[0]
	result[1] = coord[1] + move[1]
	return result
end

def trackPath(current, count)
	newSquare(current.coord[0],current.coord[1],[0.2,0.4,0.2,1])
	Text.new(count+1,x:current.coord[0]*20,y:+current.coord[1]*20,size: 11)
end

def foundBarrier(coord,border)
	if border.include? coord
		return true
	end
	if coord[0] == -1
		return true
	end
	if coord[1] == -1
		return true
	end
	if coord[0] > 24
		return true
	end
	if coord[1] > 24
		return true
	end
	return false
end

def newNode(coord,start,goal,move,parent)
	arr = getScores(coord, goal, start, move)
	coord = newCoord(coord,move)
	return Node.new(coord,arr[0],arr[1],arr[2],parent)
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

def drawBorder(x,y)
	x = x[0..x.length-2]
	y = y[0..y.length-2]
	if x.to_i.odd?
		x = x.to_i - 1
	end
	if y.to_i.odd?
		y = y.to_i - 1
	end
	x = x.to_i/2
	y = y.to_i/2
	$border.push([x,y])
	drawSquares()
end

def drawSquares()
	i = 0
	j = 0
	k = 0
	goal = [10,3]
	start = [19,17]
	while i <= 25
		while j <= 25
			if specificBlock(i,j,goal)
				clr = [0.4,0.8,0.2,1]
				newSquare(i,j,clr)
				j += 1
				next
			end
			if specificBlock(i,j,start)
				clr = [1,0.4,0.3,1]
				newSquare(i,j,clr)
				j += 1
				next
			end
			heur = findDistance(i,j,goal)
			c = detColor(heur)
			clr = [c,c,c,1]
			newSquare(i,j,clr)
			j += 1
		end
		j = 0
		i += 1
	end
	aStar(goal,start,$border)
end

class Node
	def initialize(coord, g_score, h_score, f_score, parent)
		@coord = coord
		@g = g_score
		@h = h_score
		@f = f_score
		@p = parent
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
	def parent
		@p
	end
end

def aStar(goal,start,border)
	i = 0
	while i < border.length
		newSquare(border[i][0],border[i][1],[0.4,0.2,0.8,1])
		i += 1
	end
	opened = []
	closed = []
	moves = [[0,1],[-1,0],[0,-1],[1,0]]
	opened.push(newNode(start,start,goal,[0,0],nil))
	count = 0
	while opened.length > 0
		current = findMinScore(opened)
		opened.delete(current)
		closed.push(current)
		if current.coord == goal
			path = []
			current_node = current
			i = 0
			while current_node.coord != start
				path.push(current_node)
				current_node = current_node.parent
				i += 1
			end
			path = path.reverse
			i = 0
			while i < path.length
				trackPath(path[i], i)
				i += 1
			end
			return
		end
		i = 0
		while i <= 3
			child = newNode(current.coord,start,goal,moves[i],current)
			if foundBarrier(child.coord,border)
				closed.push(child)
				i += 1
				next
			end
			if closed.any?{|a| a.coord == child.coord}
				i += 1
				next
			end
			if opened.any?{|a| a.coord == child.coord}
				gIndex = opened.find_index{|b| b.coord == child.coord}
				if child.g_score > opened[gIndex].g_score
					i += 1
					next
				end
			end
			opened.push(child)
			i += 1
		end
	end
end

on :mouse_down do |event|
	case event.button
	when :left
		x = event.x.to_s
		y = event.y.to_s
		drawBorder(x,y)
	end
end

on :key_up do |event|
	exit
end

drawSquares()
show