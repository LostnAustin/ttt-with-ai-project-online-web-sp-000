
class Game


  attr_accessor :board, :player_1, :player_2, :cells, :winner
  WIN_COMBINATIONS = [  [0,1,2], #Top ROW
  [0,3,6],
  [0,4,8],
  [1,4,7],
  [2,5,8],
  [2,4,6],
  [3,4,5],
  [6,7,8]]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def turn_count
    count = 0
    cells.each do |turn|
  if (turn == "X" || turn == "O")
     count += 1
        end
      end
  return count
    end

  def current_player
    @board.turn_count % 2 == 0 ? player_1 : player_2
      # if turn_count has a remainder of 0 (player1): if turn_counthas a remainder (player2)
  end

  def won?
    WIN_COMBINATIONS.detect do |win_combination|
    @board.cells[win_combination[0]] ==  @board.cells[win_combination[1]] &&
    @board.cells[win_combination[1]] == @board.cells[win_combination[2]] &&
     (@board.cells[win_combination[0]] == "X" ||  @board.cells[win_combination[0]] == "O")
    end
  end

  def full?
    @board.cells.all?{|token| token == "X" || token == "O"}
  end


  def draw?
    !won? && full?
  end

  def over?
    won? || draw?
  end

  def winner
  if win_combo = won?
    @winner = @board.cells[win_combo.first]
      end
    end



    def turn
        #binding.pry
      player = current_player
      pmove = player.move(@board.cells)

      if board.valid_move?(pmove)
            board.update(pmove, player)
            board.display
      else
        turn
        puts "Next Player's turn"
        end
      end


    def play
      until over?
        turn
      end
      if won?
      puts "Congratulations #{winner}!"
    elsif draw? == true
    puts "Cat's Game!"
      end
    end

    def start
        puts "Welcome to TicTacToe"
        puts "Would you like to play with 0, 1 or 2 players?"
        players_count = gets.strip
        puts "Who should go first?"
        first_player = gets.strip

        board.display


      if players_count == "0" && first_player == "1" || first_player == "2"
          @player_1 = Players::Computer.new("X")
          @player_2 = Players::Computer.new("O")
        #    Game.new(Players::Computer.new("X"), Players::Computer.new("O"), board = Board.new)
            puts "Computer vs. Computer"

      elsif players_count == "1" && first_player == "1"
        @player_1 = Players::Human.new("X")
        @player_2 = Players::Computer.new("O")
             puts "You go first"

      elsif players_count == "1" && first_player == "2"
        @player_1 = Players::Computer.new("X")
        @player_2 = Players::Human.new("O")
            puts "Computer goes first"

      elsif players_count == "2" && first_player == "1"
          Game.new(Players::Human.new("X"), Players::Human.new("O"), board = Board.new)
          puts "Player 1 goes first"

      elsif players_count =="2" && first_player == "2"
          Game.new(Players::Human.new("O"), Players::Human.new("X"), board = Board.new)
          puts "Player 2 goes first"
        end

        play
        if over?
          puts "Would you like to play again?"
          answer = gets.strip
          if answer == "yes" || answer == "Yes"
          start
          end
        end
        end






end
