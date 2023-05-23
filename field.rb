# frozen_string_literal: true

class Field
  attr_accessor :is_set, :symbol

  def initialize
    @is_set = false
  end

  def print_field(field_number)
    if is_set
      print "|_#{symbol}_|"
    else
      print "|_#{field_number}_|"
    end
  end
end
