require 'ruby2d'

set width: 500, height: 500

def newSquare(x,y,c)
	s = Square.new
	s.x = x*20
	s.y = y*20
	s.size = 20
	s.color = [c,c,c,1]
end

def drawSquares()
	i = 0
	j = 0
	while i <= 25
		while j <= 25
			c = j*0.04
			newSquare(i,j,c)
			j += 1
		end
		j = 0
		i += 1
	end
end

drawSquares()
show