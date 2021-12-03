class DiagnosticReport
  attr_accessor :bits, :entry_length

  def initialize(bits)
    @bits = bits.to_a
    @entry_length = @bits.first.size
  end

  def self.from_file(filepath)
    new(File.foreach(filepath, chomp: true))
  end

  def bit_counts(bits)
    bit_counts_data = default_bit_counts(bits.first.size)
    bits.each do |line|
      line.each_char.to_a.each_with_index do |bit, idx|
        bit_counts_data[idx.to_i] += bit.to_i
      end
    end
    bit_counts_data
  end

  def most_common_bit_by_position(bits)
    counts_hash = bit_counts(bits)
    {}.tap do |hash|
      counts_hash.each do |bit_position, count|
        hash[bit_position] = (counts_hash[bit_position] >= (bits.size / 2.to_f)) ? 1 : 0
      end
    end
  end

  def gamma_rate_binary
    most_common_bit_by_position(@bits).reduce("") do |binary_number, (_, most_common)|
      binary_number += most_common.to_s
    end
  end

  def gamma_rate
    gamma_rate_binary.to_i(2)
  end

  def epsilon_rate_binary
    most_common_bit_by_position(@bits).reduce("") do |binary_number, (_, most_common)|
      binary_number += (most_common.zero? ? 1 : 0).to_s
    end
  end

  def epsilon_rate
    epsilon_rate_binary.to_i(2)
  end

  def part1
    gamma_rate * epsilon_rate
  end

  def o2_recursion_time(bits, start_position = 0)
    most_common = most_common_bit_by_position(bits)
    chars = []

    bits.each do |bit|
      if bit.chars[start_position].to_i == most_common[start_position]
        chars.push(bit)
      end
    end
    if chars.size == 1
      return chars.first
    end
    start_position += 1
    o2_recursion_time(chars, start_position)
  end

  def oxygen_generator_rating_binary
    o2_recursion_time(@bits)
  end

  def oxygen_generator_rating
    oxygen_generator_rating_binary.to_i(2)
  end

  def co2_recursion_time(bits, start_position = 0)
    most_common = most_common_bit_by_position(bits)
    chars = []

    bits.each do |bit|
      if bit.chars[start_position].to_i != most_common[start_position]
        chars.push(bit)
      end
    end
    if chars.size == 1
      return chars.first
    end
    start_position += 1
    co2_recursion_time(chars, start_position)
  end

  def co2_scrubber_rating_binary
    co2_recursion_time(@bits)
  end

  def co2_scrubber_rating
    co2_scrubber_rating_binary.to_i(2)
  end

  def life_support_rating
    oxygen_generator_rating * co2_scrubber_rating
  end

  def part2
    life_support_rating
  end

  private

  def default_bit_counts(length = @entry_length)
    {}.tap do |bit_counts_data|
      (0...length).each do |i|
        bit_counts_data[i] = 0
      end
    end
  end
end

if $PROGRAM_NAME  == __FILE__
  diagnostic_report = DiagnosticReport.from_file("lib/input.txt")

  part1_power = diagnostic_report.part1
  puts "Got #{part1_power} for part 1"

  part2_power = diagnostic_report.part2
  puts "Got #{part2_power} for part 2"
end
