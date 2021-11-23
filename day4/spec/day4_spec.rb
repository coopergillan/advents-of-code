require "day4"

describe Day4 do
  describe Day4::PassportList do
    subject { described_class.from_file("spec/day4_test_input.txt") }

    context "#from_file" do
      it "converts a file path to an array of raw passport strings" do
        expect(subject.raw_list.size).to eq(4)
        expect(subject.raw_list).to match_array([
          "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm",
          "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884 hcl:#cfa07d byr:1929",
          "hcl:#ae17e1 iyr:2013 eyr:2024 ecl:brn pid:760753108 byr:1931 hgt:179cm",
          "hcl:#cfa07d eyr:2025 pid:166559648 iyr:2011 ecl:brn hgt:59in",
        ])
      end
    end

    context "#count_valid_passports" do
      it "counts the valid passports" do
        expect(subject.count_valid_passports).to eq(2)
      end
    end
  end

  describe Day4::Part1::Passport do
    it "marks passports with all eight fields as valid" do
    expect(
      described_class.new(
        "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm"
      ).valid?).to be(true)
    end

    it "marks passports with all fields except the cid field as valid" do
      expect(
        described_class.new(
          "hcl:#ae17e1 iyr:2013 eyr:2024 ecl:brn pid:760753108 byr:1931 hgt:179cm",
        ).valid?).to be(true)
    end

    it "marks passports missing the required fields as invalid" do
      expect(
        described_class.new(
          "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884 hcl:#cfa07d byr:1929",
        ).valid?).to be(false)
    end
  end
end
