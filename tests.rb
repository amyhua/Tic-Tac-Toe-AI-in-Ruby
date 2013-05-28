# TESTING

test_game = TicTacToe.new
test_game.print_board
test_game.board=[["O","X","O","X"],
                ["X","O","X","X"],
                ["X","X","_","X"],
                ["X","X","X","O"]]
puts "TEST: "
test_game.print_board
puts test_game.game_over? ? "Game is over" : "Game is NOT over"
puts "TEST VICTORY CONDITIONS:"
puts test_game.lower_diag_win?("X") ? "Lower diagonal win" : "NOT a lower diagonal win"
puts test_game.vert_win?("X") ? "Vertical win" : "NOT a Vertical win"
puts test_game.horiz_win?("X") ? "IS a Horizontal win" : "NOT a Horizontal win"
puts "GAME RESULT:"
test_game.game_result

# ARRAY TESTING
puts "ARRAY TESTING:"
some_array = []
some_array.push([],[])
print some_array
for subarray in some_array
  subarray.push("aa")
end

print some_array
