
class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def guess
    puts  "please make a guess (row,column)"
    current_guess = gets.chomp.split(",")

    current_guess.each do |num|
      if !"1234567890".include?(num)
        puts "you did not enter a number"
        guess
      end
    end

    current_guess.map!(&:to_i)
  end

end


class ComupterPlayer < Player
  attr_writer :hash

  def initialize()
    super
    @hash = Hash.new {|h,k| h[k]=[]}
    @guessing_order = Array.new(4) {Array.new(4)}
  end

  def guess
    @hash.each do |k,v| #if 2 values have been guessed
      if v.count == 2  && v.any? {|pos| pos != "USED"}
        @hash[k][0] == "USED" ? guess = @hash[k][1] : guess = @hash[k][0]
        @hash[k][@hash[k].index(guess)] = "USED"
        return guess
      end
    end

    #check made guess
    @hash.has_key?

    #guess if no guess made
    @guessing_order.each_with_index do |row, r_index|
      row.each_with_index do |c_index|
        next if @hash.has_value?([r_index,c_index])
        temp_guess =
        return [r_index,c_index]
      end
    end

        #guess random number then check hash
        # guess = false
        # until guess
        #   does hash have gueses?
        #   gues = true
        #   return new guessed
        # end
        # (1..8).select {|num| }


  end

end
