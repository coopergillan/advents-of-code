class TopLevelClass
  attr_accessor :input_data

  def initialize(input_data)
    @input_data = input_data
  end

  def self.from_file(filepath)
    processed_content = File.readlines(filepath, chomp: true)

    # Instantiate the top-level class with processed data
    new(processed_content)
  end

  def solve_part1
    dial_position = 50
    input_data.reduce(0) do |zero_stops, instruction|
      direction = instruction.chars.first
      moves = instruction[1..].to_i
      # puts "direction: #{direction}"
      # puts "moves: #{moves}"
      case direction
      when "L"
        dial_position -= moves
      when "R"
        dial_position += moves
      end

      # Compute modulo to account for 100 total positions
      dial_position %= 100
      dial_position.zero? ? zero_stops + 1 : zero_stops + 0
    end
  end

  def solve_part2
    dial_position = 50
    zero_stops = 0
    input_data.each do |instruction|
			puts "zero_stops: #{zero_stops}"
			puts "dial_position: #{dial_position}"

      direction = instruction.chars.first
      moves = instruction[1..].to_i
			puts "direction: #{direction}"
			puts "moves: #{moves}"

      case direction
      when "L"
        dial_position -= moves
      when "R"
        dial_position += moves
      end

      # First compute the module to get the new raw dial position
      # new_position = dial_position % 100

      # Use divmod to see how many times it passed or rested on 0
      revolutions, new_position = dial_position.divmod(100)
      puts "revolutions: #{revolutions} - new_position: #{new_position}"

      # If the dial STOPPED right at zero,Add to the count if it stopped right at zero
      if new_position.zero?
        zero_stops += 1
      # If the revolutions are negative, the module is an extra position negative
      if revolutions.negative?
        zero_stops += revolutions.abs - 1
      # elsif 
      end

        # Then add ONE LESS from divmod to account for any other revolutions
        zero_stops += revolutions - 1
      else
        # Add other times that it revolved
        zero_stops += revolutions.abs
      end
      puts "zero_stops at end of check: #{zero_stops}\n\n"

      dial_position = new_position
    end

    zero_stops
  end
end

if $PROGRAM_NAME  == __FILE__
  # top_level_instance = TopLevelClass.from_file("spec/test_input.txt")
  top_level_instance = TopLevelClass.from_file("lib/input.txt")

  part1 = top_level_instance.solve_part1
  puts "Part one answer: #{part1}"

  # part2 = top_level_instance.solve_part2
  # puts "Part two answer: #{part2}"
end
