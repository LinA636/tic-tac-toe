# frozen_string_literal: true

class BoardGame
  NUMBER_OF_FIELDS = 9

  attr_accessor :fields_arr, :current_player, :player1, :player2

  def initialize(player_one, player_two)
    @fields_arr = Array.new(NUMBER_OF_FIELDS) {Field.new}
    @current_player = player_one
    @player1 = player_one
    @player2 = player_two
  end

  def print_game
    fields_arr.each_with_index do |field, index|
      if ((index + 1) % 3).zero?
        puts field.print_field(index + 1)
      else
        print field.print_field(index + 1)
      end
    end
  end

  def check_victory
    # check rows and colums
    3.times do |i|
      if check_3_same_symbols(fields_arr[i * 3..i * 3 + 2]) || check_3_same_symbols(fields_arr.values_at(i, i + 3,
                                                                                                         i + 6))
        return true
      end
    end
    # check diagonals
    2.times do |i|
      return true if check_3_same_symbols(fields_arr.values_at(i * 6, 4, 8 - i * 6))
    end
    false
  end

  def check_full_board
    fields_arr.all?(&:is_set)
  end

  def choose_field
    print "#{current_player.name} choose a field: "
    field_number = gets.chomp.to_i
    field_number = check_player_field_number_input(field_number)
    mark_field(field_number)
  end

  def actualise_current_player
    self.current_player = current_player == player1 ? player2 : player1
  end

  def announce_winner
    actualise_current_player
    puts "Congrats #{current_player.name}, you won!"
  end

  def announce_tie
    puts "It's a tie. No one wins."
  end
  # private methods

  private

  def check_3_same_symbols(three_fields)
    three_fields.any?(&:is_set) && (three_fields.map(&:symbol).uniq.length == 1)
  end

  def check_player_field_number_input(number)
    number = player_input_is_number?(number)
    check_field_occupied?(number)
  end

  def player_input_is_number?(field_number)
    until field_number.between?(1, 9)
      print "#{current_player} choose a number between 1 and 9: "
      field_number = gets.chomp.to_i
    end
    field_number
  end

  def check_field_occupied?(field_number)
    while fields_arr[field_number - 1].is_set
      print "#{current_player} choose another, unoccupied field: "
      field_number = gets.chomp.to_i
    end
    field_number
  end

  def mark_field(number)
    fields_arr[number - 1].is_set = true
    fields_arr[number - 1].symbol = current_player.symbol
  end
end
