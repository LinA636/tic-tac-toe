class BoardGame
  attr_accessor :number_of_fields, :fields_arr

  def initialize(number_of_fields)
    @number_of_fields = number_of_fields
    @fields_arr = []
end