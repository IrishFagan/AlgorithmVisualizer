require 'ruby2d'

set width: 500, height: 500

def findDistance(x,y,coord)
	x = x - coord[0]
	y = y - coord[1]
	heur = x.abs+y.abs
	return heur
end

def findMinScore(arr)
	arr.sort! { |a,b| a.f_score <=> b.f_score}
	return arr[0]
end

def getScores(crnt,goal,start,move)
	g = findDistance(crnt[0],crnt[1],start) + move[0] + move[1]
	h = findDistance(crnt[0],crnt[1],goal)
	f = g + h
	return [f,g,h]
end

def newCoord(coord,move)
	result = []
	result[0] = coord[0] + move[0]
	result[1] = coord[1] + move[1]
	return result
end

def foundBarrier(coord,border)
	if border.include? coord
		puts "COLLISSION: "+coord.to_s
		return true
	end
	if coord[0] == -1
		return true
	end
	if coord[1] == -1
		return true
	end
	if coord[0] > 25
		return true
	end
	if coord[1] > 25
		return true
	end
	return false
end

def newNode(coord,start,goal,move)
	arr = getScores(coord, goal, start, move)
	coord = newCoord(coord,move)
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
	k = 0
	goal = [0,0]
	start = [22,8]
	border = [[5,5],[6,5],[7,5],[8,5],[9,5],[5,0],[5,1],[5,2],[5,3],[5,4]]
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

def aStar(goal,start,border)
	opened = []
	closed = []
	moves = [[0,1],[-1,0],[0,-1],[1,0]]
	opened.push(newNode(start,start,goal,[0,0]))
	while opened.length > 0
		current = findMinScore(opened)
		newSquare(current.coord[0],current.coord[1],[0.2,0.4,0.2,1])
		puts
		puts "Current: ["+current.coord[0].to_s+","+current.coord[1].to_s+"]"
		if current.coord == goal
			puts "FOUND!"
			return
		end
		i = 0
		while i <= 3
			child = newNode(current.coord,start,goal,moves[i])
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
				print "IndexCoord: "+gIndex.to_s
				puts
				if child.g_score > opened[gIndex].g_score
					i += 1
					next
				end
			end
			puts "Child: ["+child.coord[0].to_s+","+child.coord[1].to_s+"], Move: "+moves[i].to_s
			opened.push(child)
			i += 1
		end
		opened.delete(current)
		closed.push(current)
	end
	l = 0
	while l < closed.length
		puts "Closed: ["+closed[l].coord[0].to_s+","+closed[l].coord[1].to_s+"]"
		l += 1
	end
end

on :key_up do |event|
	exit
end

drawSquares()
show