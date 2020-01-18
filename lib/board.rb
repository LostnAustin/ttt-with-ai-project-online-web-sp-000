class Board
  attr_accessor :cells

  def initialize
  #  token == "X" || token == "O"
    reset!
  end

  def reset!
    @cells = Array.new(9, " ")
  end

  def display
    puts " #{@cells[0]} | #{@cells[1]} | #{@cells[2]} "
    puts "-----------"
    puts " #{@cells[3]} | #{@cells[4]} | #{@cells[5]} "
    puts "-----------"
    puts " #{@cells[6]} | #{@cells[7]} | #{@cells[8]} "
  end


  def position(input)
    cells[input.to_i - 1]
  end

  def full?
    cells.all? {|char| char == "X" || char == "O"}
  end

  def turn_count
    count = 0

    @cells.each do |turn|
      # binding.pry
      # puts "hello"
      if (turn == "X" || turn == "O")
        count += 1
      end
    end
    return count
  end

    def taken?(input)
      position(input) == "X" || position(input) == "O"
      #if @cells(index) is NOT nil or @cells(index) is equal to " "
    end

    def valid_move?(input)
    !taken?(input.to_i) && input.to_i.between?(1,9)
    end

    def update(input, player)
      cells[input.to_i - 1] = player.token
    end

end
