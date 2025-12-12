require "solver"

describe TopLevelClass do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to the data" do
      expect(subject.input_data).to match_array(
        %w[L68 L30 R48 L5 R60 L55 L1 L99 R14 L82]
      )
    end
  end

  context "#solve_part1" do
    it "solves part one" do
      expect(subject.solve_part1).to eq(3)
    end
	end

  context "#solve_part2" do
    it "solves part two" do
      expect(subject.solve_part2).to eq(6)
    end
  end
end
