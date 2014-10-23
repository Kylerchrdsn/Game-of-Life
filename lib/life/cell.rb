class Life::Cell
  attr_accessor :alive
  alias :alive? :alive
  #***************************************
  def initialize alive = false
    @alive = alive
  end
end # class
