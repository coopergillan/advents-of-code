require "day4"

describe Day4 do
  describe Day4::PassportList do

    context "#from_file" do
      subject { described_class.from_file("spec/day4_part1_test_input.txt") }

      it "converts a file path to an array of raw passport strings" do
        expect(subject.entries.size).to eq(4)
        expect(subject.entries).to match_array([
          "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm",
          "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884 hcl:#cfa07d byr:1929",
          "hcl:#ae17e1 iyr:2013 eyr:2024 ecl:brn pid:760753108 byr:1931 hgt:179cm",
          "hcl:#cfa07d eyr:2025 pid:166559648 iyr:2011 ecl:brn hgt:59in",
        ])
      end
    end

    context "#count_valid_passports_part1" do
      it "counts the valid passports" do
        valid1 = "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm"
        invalid_no_height = "iyr:2013 ecl:amb cid:350 eyr:2023 pid:028048884 hcl:#cfa07d byr:1929"
        valid2 = "hcl:#ae17e1 iyr:2013 eyr:2024 ecl:brn pid:760753108 byr:1931 hgt:179cm"
        invalid_no_byr = "hcl:#cfa07d eyr:2025 pid:166559648 iyr:2011 ecl:brn hgt:59in"

        passport_list = described_class.new([
          valid1, invalid_no_height, valid2, invalid_no_byr,
        ])
        expect(passport_list.count_valid_passports_part1).to eq(2)
      end
    end

    context "#count_valid_passports_part2" do
      let(:invalid_hgt) { "eyr:1972 cid:100 hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926" }
      let(:invalid_no_hgt) { "iyr:2019 hcl:#602927 eyr:1967 hgt:170cm ecl:grn pid:012533040 byr:1946" }
      let(:invalid_hcl) { "hcl:dab227 iyr:2012 ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277" }
      let(:invalid_several) { "hgt:59cm ecl:zzz eyr:2038 hcl:74454a iyr:2023 pid:3556412378 byr:2007" }

      let (:valid1) { "pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980 hcl:#623a2f" }
      let (:valid2) { "eyr:2029 ecl:blu cid:129 byr:1989 iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm" }
      let (:valid3) { "hcl:#888785 hgt:164cm byr:2001 iyr:2015 cid:88 pid:545766238 ecl:hzl eyr:2022" }
      let (:valid4) { "iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719" }


      it "finds no valid passports when only invalid entries given" do
        passport_list = described_class.new([
          invalid_hgt, invalid_no_hgt, invalid_hcl, invalid_several,
        ])
        expect(passport_list.count_valid_passports_part2.zero?).to be(true)
      end

      it "finds number of valid passports when valid entries given" do
        passport_list = described_class.new([
          valid1, valid2, valid3, valid4,
        ])
        expect(passport_list.count_valid_passports_part2).to eq(4)
      end

      it "finds number of valid passports when a mix of entries given" do
        passport_list = described_class.new([
          valid1, invalid_hgt, valid2, invalid_no_hgt, invalid_several, valid4,
        ])
        expect(passport_list.count_valid_passports_part2).to eq(3)
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

  describe Day4::Part2::Passport do
    context "#from_raw" do
      it "instantiates all attributes with raw entry" do
        raw_entry = "ecl:gry pid:860033327 eyr:2020 hcl:#fffffd byr:1937 iyr:2017 cid:147 hgt:183cm"
        passport = described_class.from_raw(raw_entry)
        expect(passport.attributes).to include({
          byr: "1937",
          iyr: "2017",
          eyr: "2020",
          hgt: "183cm",
          hcl: "#fffffd",
          ecl: "gry",
          pid: "860033327",
        })
      end
    end
  end

  describe "Part 2 attribute classes" do
    context Day4::Part2::BirthYear do
      it "accepts a string and returns true for a BirthYear in the given range" do
        birth_year = described_class.new("1937")
        expect(birth_year.valid?).to be(true)
      end

      it "accepts a string and returns true for a BirthYear on the edge of the given range" do
        birth_year = described_class.new("1920")
        expect(birth_year.valid?).to be(true)
      end

      it "accepts a string and returns false for a BirthYear outside the given range" do
        birth_year = described_class.new("2003")
        expect(birth_year.valid?).to be(false)
      end
    end

    context Day4::Part2::IssueYear do
      it "accepts a string and returns true for an IssueYear in the given range" do
        issue_year = described_class.new("2014")
        expect(issue_year.valid?).to be(true)
      end

      it "accepts a string and returns true for an IssueYear on the edge of the given range" do
        issue_year = described_class.new("2020")
        expect(issue_year.valid?).to be(true)
      end

      it "accepts a string and returns false for an IssueYear outside the given range" do
        issue_year = described_class.new("2009")
        expect(issue_year.valid?).to be(false)
      end
    end

    context Day4::Part2::ExpirationYear do
      it "accepts a string and returns true for an ExpirationYear in the given range" do
        expiration_year = described_class.new("2025")
        expect(expiration_year.valid?).to be(true)
      end

      it "accepts a string and returns true for an ExpirationYear on the edge of the given range" do
        expiration_year = described_class.new("2030")
        expect(expiration_year.valid?).to be(true)
      end

      it "accepts a string and returns false for a ExpirationYear outside the given range" do
        expiration_year = described_class.new("2019")
        expect(expiration_year.valid?).to be(false)
      end
    end

    context Day4::Part2::Height do
      context "when height given in inches" do
        it "returns true for a value within the range" do
          height = described_class.new("62in")
          expect(height.valid?).to be(true)
        end

        it "returns false for a value outside the range" do
          height = described_class.new("80in")
          expect(height.valid?).to be(false)
        end

        it "returns true for a value at the edge of the range" do
          height = described_class.new("76in")
          expect(height.valid?).to be(true)
        end
      end

      context "when height given in centimeters" do
        it "returns true for a value within the range" do
          height = described_class.new("165cm")
          expect(height.valid?).to be(true)
        end

        it "returns false for a value outside the range" do
          height = described_class.new("140cm")
          expect(height.valid?).to be(false)
        end

        it "returns true for a value at the edge of the range" do
          height = described_class.new("193cm")
          expect(height.valid?).to be(true)
        end
      end

      context "when invalid input given" do
        it "is invalid when other units are provided" do
          height = described_class.new("2.4m")
          expect(height.valid?).to be(false)
        end
        it "is invalid when no input provided" do
          height = described_class.new(nil)
          expect(height.valid?).to be(false)
        end
      end
    end

    context Day4::Part2::HairColor do
      it "returns true for a valid hex color" do
        hair_color = described_class.new("#602fce")
        expect(hair_color.valid?).to be(true)
      end

      it "returns false for an invalid hex color" do
        hair_color = described_class.new("#602qrs")
        expect(hair_color.valid?).to be(false)
      end

      it "returns false for non-hex input" do
        hair_color = described_class.new("Brown")
        expect(hair_color.valid?).to be(false)
      end
    end

    context Day4::Part2::EyeColor do
      it "returns true for an accepted value" do
        eye_color = described_class.new("gry")
        expect(eye_color.valid?).to be(true)
      end

      it "returns false for a different value" do
        eye_color = described_class.new("purple")
        expect(eye_color.valid?).to be(false)
      end
    end

    context Day4::Part2::PassportId do
      context "given valid nine-digit input" do
        it "returns true" do
          passport_id = described_class.new("314159265")
          expect(passport_id.valid?).to be(true)
        end

        it "returns true even when value starts with leading zeroes" do
          passport_id = described_class.new("023332718")
          expect(passport_id.valid?).to be(true)
        end
      end

      context "given invalid input" do
        it "returns false for not enough digits" do
          passport_id = described_class.new("12345678")
          expect(passport_id.valid?).to be(false)
        end

        it "returns false for too many digits" do
          passport_id = described_class.new("1234567890")
          expect(passport_id.valid?).to be(false)
        end

        it "returns false for non-digit input" do
          passport_id = described_class.new("sweden")
          expect(passport_id.valid?).to be(false)
        end
      end
    end
  end
end
