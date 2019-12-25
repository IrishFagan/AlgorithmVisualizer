require 'ruby2d'

set width: 500, height: 500

def newSquare(x,y,clr)
	sqr = Square.new
	sqr.x = x*20
	sqr.y = y*20
	sqr.size = 20
	sqr.color = clr
end

def goalCheck(x,y)
	goal = [22,3]
	if goal == [x,y]
		return true
	end
	return false
end

def drawSquares()
	i = 0
	j = 0
	start = [0,0]
	while i <= 25
		while j <= 25
			c = j*0.04
			clr = [c,c,c,1]
			newSquare(i,j,clr)
			if goalCheck(i,j)
				clr = [0,0.8,0.2,1]
				newSquare(i,j,clr)
			end
			j += 1
		end
		j = 0
		i += 1
	end
end

drawSquares()
show