# AMY HUA
# amyhua@gmail.com
# Last updated: May 28, 2013 2:50PM EST
# Last updated: June 4, 2013 7:17PM EST

  class TicTacToe
    # A TicTacToeGame is roughly defined by:
    # 1. A nxn gameboard that users can see throughout turns

    #      (We usually assume n = 3. Code can be generalized to
    #       any odd number n >=3, with some additional work)
    #       n is always assumed odd and >= 3 (games of n<3 are trivial)
    #       Assume n <= 99
    # 2. Two players, p1 (plays with marker "X") & p2 (plays with marker "O")
    # 3. Win, Loss, and Tie / Victory Conditions
    # 4. Player Actions (e.g. making a turn, undoing a round)
  
    attr_accessor :board
    attr_accessor :rboard #rotated board (rotated board by 90 degrees cw)
    attr_accessor :size
    
  
    def initialize()
      puts ""
      puts "**********************************************"
      puts "**** WELCOME TO A NEW GAME OF TIC TAC TOE ****"
      puts "**********************************************"
      puts "***** DURING YOUR TURN, CHOOSE YOUR NEXT  ****"
      puts "***** MOVE BY SPECIFYING THE iTH ROW AND  ****"
      puts "***** jTH COLUMN YOU WANT TO MOVE TO IN   ****"
      puts "***** (i,j) FORMAT                        ****"      
      puts "**********************************************"
      puts ""

      puts "What NxN size gameboard do you want to play? E.g. 3, 4, 5, etc. (Max=99): "

      size_s = gets.chomp

      @size = size_s.to_i
      puts "***** LET'S BEGIN!  **************************"
      
      @board = []
      size.times do
        self.board.push([])
      end

      for row in self.board
        size.times do
          row.push("_")
        end
      end
      
      @rboard = []
      size.times do
        self.rboard.push([])
      end
      for row in self.rboard
        size.times do
          row.push("_")
        end
      end

    end
      
    def print_board(option={})
      if option =={}
        bd = self.board
      elsif option ==1
        bd = self.rboard
      else
        raise ArgumentError
      end

      n = size-1
      for i in (0..n)
        for j in (0..n)
          print "  " + bd[i][j] + "  "
        end
          print "\n\n"
      end
    end
        
    def game_over?()
      self.board.flatten.all? {|entry| (entry != "_")}
    end
    
    
    # ------------ ** VICTORY CONDITIONS ** -------------

    def straight_win?(marker,m=size,option={}) # option: nil (original board) or 1 (rotated board)
      
      if option == {}
        bd = self.board
      elsif option == 1
        bd = self.rboard
      else
        raise ArgumentError
      end      

      if m==1 # base case
        bd[0].all?{|element| element == marker}
      elsif bd[m-1].all?{|element| element == marker}
        puts "Horizonal win with option " + option.to_s + " and m " + m.to_s
        return true
      else
        straight_win?(marker,m-1,option)        
      end
    end
        
    def lower_diag_win?(marker)
      # Upper Left to Lower Right Diagonal Win
      diagonal_twins?(size) && self.board[0][0]==marker
    end
    
    def upper_diag_win?(marker)
      # Lower Left to Upper Right Diagonal Win
      # ** ROTATE BOARD, THEN do the same as lower_diag_win?
      diagonal_twins?(size,1) && self.rboard[0][0]==marker

    end
    
    def diagonal_twins?(n,option={}) # n>=2; option: nil (original board) or 1 (rotated board)
      #checks if pairs of adjacent elements along the (lower) diagonal of the board are both identical
      if option == {}
        bd = self.board
      elsif option == 1
        bd = self.rboard
      else
        raise ArgumentError
      end

      if n == 2 # base case
        bd[n-1][n-1]==bd[n-2][n-2]
      elsif bd[n-1][n-1]==bd[n-2][n-2]
        diagonal_twins?(n-1,option)
      else
        return false
      end
    end
    
    def won?(player) # player = 1 or 2
      marker = "X" if player == 1
      marker = "O" if player == 2
      straight_win?(marker) || straight_win?(marker,size,1) || lower_diag_win?(marker) || upper_diag_win?(marker)
    end

=begin   
    def game_result() # assume game has an end result already (win/ loss/ tie)
          if won?(1)
          puts "Player 1 (X) WINS!"
          elsif won?(2)
          puts "Player 2 (O) WINS!"
          else
          puts "TIE!"
          end
      end

    end
=end
    
    # ------------ ** PLAYER ACTIONS ** -------------    
    
    def move(player) # player = 1 or 2
      
    # update rotated board

    for i in (0...size)
      for j in (0...size)
        self.rboard[i][j] = self.board[size-1-j][i]
      end
    end
    
    # check if partial game
     if won?(1)
       puts "*** Player 1 WINS! ***"
     elsif won?(2)
       puts "*** PLAYER 2 WINS! ***"
     elsif game_over?
       puts "*** TIE! ***"
     else
       # is a partial game
       # identify opponent and player
      if player == 1
        marker = "X" 
        opponent = 2
      end
      if player == 2
        marker = "O"
        opponent = 1
      end
      # prompt player to make their move
      print "Player " + player.to_s + ", make your move (row, column). Say EXIT to surrender: "
      move = gets.chomp # expected in "(i,j)" format
      # error-check for proper format
      if move =~ /[(](\d|\d\d)|[,](\d|\d\d)[)]/
        i = move.match(/(\d|\d\d)/).to_s.to_i
        j = move.match(/(\d|\d\d)/, move.index(',')).to_s.to_i
        
        if i > 0 && i <= size && j > 0 && j <= size
          # correct format, no error scenario
          i = i-1
          j = j-1
          if self.board[i][j] == "_"
            self.board[i][j] = marker
            puts ""
            print_board
            puts ""
            move(opponent)
          else
            puts "***** ERROR: That position is already taken        ********"
            puts "***** Try again                                    *********"
            move(player)
          end
        else
          puts "***** ERROR: improper no. rows and/or columns    *********"
          puts "***** Try again                                  *********"
          move(player)
        end
      elsif move != "EXIT"
        puts "***** ERROR: improper format. Use (i,j) format     *********"
        puts "***** Try again                                    *********"
        move(player)        
      elsif move == "EXIT"
        puts "*** Player " + opponent.to_s + " WINS! ***"
      else
        raise ArgumentError
      end
     end
      
    end
    
    # ------------ ** GAME ACTIONS ** -------------    
    
    
  end #class end

# BEGIN GAME

def new_game()
  g = TicTacToe.new
  g.print_board
  g.move(1)
  print "Do you want to play a new game? (Y/N): "
  ans = gets.chomp
  if ans.upcase == "Y"
    new_game
  elsif ans.upcase == "N"
    exit
  else
    raise ArgumentError
  end
end

new_game
