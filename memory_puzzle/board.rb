require_relative "card"

class Board
  def self.create_cards
    card_arr = []
    (1..8).cycle(2).each do |num|
      num = Card.new(num.to_s)
      card_arr << num
    end
    card_arr
  end
  attr_reader :grid
  def initialize(grid = Array.new(4) {Array.new(4)})
    @grid = grid
  end

  def populate
    card_array = Board.create_cards
    @grid.each_with_index do |row, idx|
      row.each_index do |column_index|
        @grid[idx][column_index] = card_array.shuffle!.shift
      end
    end
  end

  def render
    @grid.each do |row|
      p row.map {|card| card.display}
    end
  end

  def won?
    @grid.flatten.none? {|card| card.display == "X"}
  end

  def reveal(pos)
    x,y = pos
    if !@grid[y][x].face_up
        @grid[y][x].reveal
        @grid[y][x].name
    end
  end

end
