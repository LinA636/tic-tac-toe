# frozen_string_literal: true

class Player
  attr_accessor :symbol, :name

  def initialize(symbol, name)
    @symbol = symbol
    @name = name
  end

  def mark_field(field)
    field.mark_field(symbol)
  end
end
