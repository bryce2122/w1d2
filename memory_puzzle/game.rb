require_relative "board"
require_relative "player"
require 'byebug'

class Game

  def initialize(board = Board.new,player_1,player_2)
    @board = board
    @previous_card = nil
    @current_card = nil
    @player_1 = player_1
    @player_2 = player_2
    @current_player = player_1
  end

  def is_valid?(row,column)
    if @board.grid[column][row].face_up
      false
    elsif row > 3 || row < 0
      false
    elsif column > 3 || row < 0
      false
    else
      true
    end
  end

  def switch_player
    if @current_player == @player_1
      @current_player = @player_2
    else
      @current_player = @player_1
    end
  end

  def make_guess
    guess = @current_player.guess

    row, column = guess

    if is_valid?(row,column)
      @current_card,@previous_card = @board.grid[column][row],@current_card
      guess_record(guess)
      @board.reveal([row,column])
    else
      puts "Not a valid guess"
      make_guess
    end

  end

  def guess_record(location)
      if @player_1.class == ComputerPlayer
        @player_1.hash[@current_card.name] << location
      elsif @player_2.class == ComputerPlayer
        @player_2.hash[@current_card.name] << location
      end
  end



  def check_cards
    if @current_card.name == @previous_card.name
      puts "It's a match!"
      true
    else
      puts "You didn't guess correct"
      false
    end
  end

  def play
    @board.populate

    until @board.won?
      @board.render
      make_guess
      make_guess
      @board.render
      sleep(4)
      unless check_cards
        @current_card.hide
        @previous_card.hide
      end
      system("clear")
      switch_player
    end
  end

  end

  if __FILE__ == $PROGRAM_NAME
    player_1 = Player.new("Kyle")
    player_2 = Player.new("Sam")
    game = Game.new(player_1,player_2)
    game.play
  end
