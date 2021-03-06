class BingoGame
  attr_accessor :drawn_numbers, :boards

  def initialize(drawn_numbers, boards)
    @drawn_numbers = drawn_numbers
    @boards = boards
  end

  def self.from_file(filepath)
    raw_content = File.read(filepath, chomp: true).split("\n\n")

    drawn_numbers = raw_content.shift.split(",").map(&:to_i)
    boards = raw_content.map { |raw_board| BingoBoard.from_raw(raw_board) }

    new(drawn_numbers, boards)
  end

  def part1
    @drawn_numbers.each do |number|
      @boards.each do |board|
        board.call_number(number)
        if board.has_win?
          return board.final_score(number)
        end
      end
    end
  end

  def part2
    boards_in_play = @boards.clone
    @drawn_numbers.each do |number|
      @boards.each do |board|
        board.call_number(number)

        if !board.won && board.has_win?
          if boards_in_play.one?
            return board.final_score(number)
          end
          board.won = true
          boards_in_play.delete(board)
        end
      end
    end
  end
end

class BingoBoard
  attr_accessor :board, :won

  def initialize(board)
    @board = board
    @won = false
  end

  def self.from_raw(raw_board)
    new(
      raw_board.split(/\n/).map do |line|
        line.split.map { |raw_number| {value: raw_number.to_i, called: false} }
      end
    )
  end

  def call_number(number)
    @board.each do |row|
      row.each do |spot|
        spot[:called] = true if number == spot[:value]
      end
    end
  end

  def uncalled_numbers
    uncalled = []
    @board.each do |row|
      row.each do |spot|
        uncalled.push(spot[:value]) if spot[:called] == false
      end
    end
    uncalled
  end

  def has_win?
    has_row_win? || has_column_win?
  end

  def final_score(called_number)
    uncalled_numbers.reduce(:+) * called_number
  end

  private

  def has_row_win?
    @board.map { |row| row.map { |spot| spot[:called] }.all? }.any?
  end

  def has_column_win?
    @board.transpose.map { |row| row.map { |spot| spot[:called] }.all? }.any?
  end
end


if $PROGRAM_NAME  == __FILE__
  bingo_game1 = BingoGame.from_file("lib/input.txt")
  part1_answer = bingo_game1.part1
  puts "Answer for part 1: #{part1_answer}"

  bingo_game2 = BingoGame.from_file("lib/input.txt")
  part2_answer = bingo_game2.part2
  puts "Answer for part 2: #{part2_answer}"
end
