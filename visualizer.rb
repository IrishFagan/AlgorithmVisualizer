require 'ruby2d'

set width: 500, height: 500

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

def drawSquares()
	i = 0
	j = 0
	k = 0
	goal = [10,3]
	start = [19,22]
	border = [[10,13],[10,14],[10,15],[15,12],[16,12],[17,12],[18,12],[19,12],[14,12],[13,12],[12,12],[11,12],[10,12]]
	while i <= 25
		while j <= 25
			if border.include? [i,j]
				clr = [0.5,0.8,0.1,1]
				newSquare(i,j,clr)
				j += 1
				next
			end
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
	aStar(goal,start,border)
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
				puts "Move #"+(i+1).to_s+": ["+path[i].coord[0].to_s+","+path[i].coord[1].to_s+"]"
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
	l = 0
	while l < closed.length
		l += 1
	end
end

on :key_up do |event|
	exit
end

drawSquares()
show