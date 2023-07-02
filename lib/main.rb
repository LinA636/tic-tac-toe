# include required classes
require_relative "./player"
require_relative "./board_game"
require_relative "./field"

def startGame()
  # create players
  player1 = Player.new("w", "player1")
  player2 = Player.new("x", "player2")

  # create game-board
  game = BoardGame.new(player1, player2)
  game.print_game()

 until game.check_victory() || game.check_full_board()
    game.choose_field()
    game.print_game()
    game.actualise_current_player()
 end

 if game.check_full_board()
  game.announce_tie()
 else
  game.announce_winner()
 end

end

startGame()
