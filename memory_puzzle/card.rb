
class Card
  attr_reader :name, :face_up

  def initialize(name)
    @name = name
    @face_up = false
  end

  def display
    return @name if @face_up
    return "X"
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

end
