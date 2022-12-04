require "solver"

describe Assignments do
  subject { described_class.from_file("spec/test_input.txt") }

  context "#from_file" do
    it "converts a file path to processed data for use in lower-level class" do
      expect(subject.input_data).to match_array([
        [2, 4, 6, 8],
        [2, 3, 4, 5],
        [5, 7, 7, 9],
        [2, 8, 3, 7],
        [6, 6, 4, 6],
        [2, 6, 4, 8],
      ])
    end
  end

  context "#solve_part1" do
    it "solves part one" do
      expect(subject.solve_part1).to eq(2)
    end
  end

  context "#solve_part2" do
    it "solves part two" do
      expect(subject.solve_part2).to eq(8)
    end
  end
end

describe ParticularClass do
  context "#from_raw" do
    let(:raw_input) { ["A", "Z"] }
    subject { described_class.from_raw(raw_input) }

    it "translates the raw input into separate values" do
      expect(subject.input1).to eq("A")
      expect(subject.input2).to eq("Z")
    end
  end
end
