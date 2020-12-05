import 'package:aoc2020/day2.dart' as day2;
import 'package:aoc2020/day3.dart' as day3;
import 'package:aoc2020/day4.dart' as day4;
import 'package:aoc2020/day5.dart' as day5;
import 'package:test/test.dart';

void main() {
  test("day 2 part a", () {
    final lines = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"];
    final results = [true, false, true];
    for (var i = 0; i < lines.length; i++) {
      final result = day2.isValidLine_A(lines[i]);
      expect(result, results[i]);
    }
  });

  test("day 2 part b", () {
    final lines = ["1-3 a: abcde", "1-3 b: cdefg", "2-9 c: ccccccccc"];
    final results = [true, false, false];
    for (var i = 0; i < lines.length; i++) {
      final result = day2.isValidLine_B(lines[i]);
      expect(result, results[i]);
    }
  });

  test("day 3 part a", () {
    final grid =
        "..##.......\n#...#...#..\n.#....#..#.\n..#.#...#.#\n.#...##..#.\n..#.##.....\n.#.#.#....#\n.#........#\n#.##...#...\n#...##....#\n.#..#...#.#";
    final count = day3.countHits(grid);
    expect(count, 7);
  });

  test("day 3 part b", () {
    final grid =
        "..##.......\n#...#...#..\n.#....#..#.\n..#.#...#.#\n.#...##..#.\n..#.##.....\n.#.#.#....#\n.#........#\n#.##...#...\n#...##....#\n.#..#...#.#";
    final count = day3.countHitOptions(grid);
    expect(count, 336);
  });

  test("day 4 part b", () {
    expect(day4.checkYearField("2002", 1920, 2002), true);
    expect(day4.checkYearField("2003", 1920, 2002), false);

    expect(day4.checkHeight("60in"), true);
    expect(day4.checkHeight("190cm"), true);
    expect(day4.checkHeight("190in"), false);
    expect(day4.checkHeight("190"), false);

    expect(day4.checkHairColor("#123abc"), true);
    expect(day4.checkHairColor("##123abz"), false);
    expect(day4.checkHairColor("123abc"), false);

    expect(day4.checkEyeColor("brn"), true);
    expect(day4.checkEyeColor("wat"), false);

    expect(day4.checkPid("000000001"), true);
    expect(day4.checkPid("0123456789"), false);
    expect(day4.checkPid("01234567a"), false);

    final invalids = """eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007""";

    final invalidEntries = day4.parseEntries(invalids);
    expect(invalidEntries.length, 4);
    expect(day4.checkAllRequiredThings(invalidEntries), 0);

    final valids = """pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719""";

    final validEntries = day4.parseEntries(valids);
    expect(validEntries.length, 4);
    expect(day4.checkAllRequiredThings(validEntries), 4);
  });

  test("Day5 part A", () {
    final input = "BFFFBBFRRR\nFFFBBBFRRR\nBBFFBBFRLL".split("\n");
    final expected = [567, 119, 820];
    for (var i = 0; i < input.length; i++) {
      expect(day5.parseNr(input[i]), expected[i]);
    }
  });
}
