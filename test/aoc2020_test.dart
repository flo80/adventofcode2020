import 'package:aoc2020/day2.dart' as day2;
import 'package:aoc2020/day3.dart' as day3;
import 'package:aoc2020/day4.dart' as day4;
import 'package:aoc2020/day5.dart' as day5;
import 'package:aoc2020/day7.dart' as day7;
import 'package:aoc2020/day8.dart' as day8;
import 'package:aoc2020/day9.dart' as day9;
import 'package:aoc2020/day10.dart' as day10;
import 'package:aoc2020/day11.dart' as day11;
import 'package:test/test.dart';

void main() {
  test('day 2 part a', () {
    final lines = ['1-3 a: abcde', '1-3 b: cdefg', '2-9 c: ccccccccc'];
    final results = [true, false, true];
    for (var i = 0; i < lines.length; i++) {
      final result = day2.isValidLine_A(lines[i]);
      expect(result, results[i]);
    }
  });

  test('day 2 part b', () {
    final lines = ['1-3 a: abcde', '1-3 b: cdefg', '2-9 c: ccccccccc'];
    final results = [true, false, false];
    for (var i = 0; i < lines.length; i++) {
      final result = day2.isValidLine_B(lines[i]);
      expect(result, results[i]);
    }
  });

  test('day 3 part a', () {
    final grid =
        '..##.......\n#...#...#..\n.#....#..#.\n..#.#...#.#\n.#...##..#.\n..#.##.....\n.#.#.#....#\n.#........#\n#.##...#...\n#...##....#\n.#..#...#.#';
    final count = day3.countHits(grid);
    expect(count, 7);
  });

  test('day 3 part b', () {
    final grid =
        '..##.......\n#...#...#..\n.#....#..#.\n..#.#...#.#\n.#...##..#.\n..#.##.....\n.#.#.#....#\n.#........#\n#.##...#...\n#...##....#\n.#..#...#.#';
    final count = day3.countHitOptions(grid);
    expect(count, 336);
  });

  test('day 4 part b', () {
    expect(day4.checkYearField('2002', 1920, 2002), true);
    expect(day4.checkYearField('2003', 1920, 2002), false);

    expect(day4.checkHeight('60in'), true);
    expect(day4.checkHeight('190cm'), true);
    expect(day4.checkHeight('190in'), false);
    expect(day4.checkHeight('190'), false);

    expect(day4.checkHairColor('#123abc'), true);
    expect(day4.checkHairColor('##123abz'), false);
    expect(day4.checkHairColor('123abc'), false);

    expect(day4.checkEyeColor('brn'), true);
    expect(day4.checkEyeColor('wat'), false);

    expect(day4.checkPid('000000001'), true);
    expect(day4.checkPid('0123456789'), false);
    expect(day4.checkPid('01234567a'), false);

    final invalids = '''eyr:1972 cid:100
hcl:#18171d ecl:amb hgt:170 pid:186cm iyr:2018 byr:1926

iyr:2019
hcl:#602927 eyr:1967 hgt:170cm
ecl:grn pid:012533040 byr:1946

hcl:dab227 iyr:2012
ecl:brn hgt:182cm pid:021572410 eyr:2020 byr:1992 cid:277

hgt:59cm ecl:zzz
eyr:2038 hcl:74454a iyr:2023
pid:3556412378 byr:2007''';

    final invalidEntries = day4.parseEntries(invalids);
    expect(invalidEntries.length, 4);
    expect(day4.checkAllRequiredThings(invalidEntries), 0);

    final valids = '''pid:087499704 hgt:74in ecl:grn iyr:2012 eyr:2030 byr:1980
hcl:#623a2f

eyr:2029 ecl:blu cid:129 byr:1989
iyr:2014 pid:896056539 hcl:#a97842 hgt:165cm

hcl:#888785
hgt:164cm byr:2001 iyr:2015 cid:88
pid:545766238 ecl:hzl
eyr:2022

iyr:2010 hgt:158cm hcl:#b6652a ecl:blu byr:1944 eyr:2021 pid:093154719''';

    final validEntries = day4.parseEntries(valids);
    expect(validEntries.length, 4);
    expect(day4.checkAllRequiredThings(validEntries), 4);
  });

  test('Day5 part A', () {
    final input = 'BFFFBBFRRR\nFFFBBBFRRR\nBBFFBBFRLL'.split('\n');
    final expected = [567, 119, 820];
    for (var i = 0; i < input.length; i++) {
      expect(day5.parseNr(input[i]), expected[i]);
    }
  });

  test('Day 7, part A', () {
    final rules =
        '''light red bags contain 1 bright white bag, 2 muted yellow bags.
dark orange bags contain 3 bright white bags, 4 muted yellow bags.
bright white bags contain 1 shiny gold bag.
muted yellow bags contain 2 shiny gold bags, 9 faded blue bags.
shiny gold bags contain 1 dark olive bag, 2 vibrant plum bags.
dark olive bags contain 3 faded blue bags, 4 dotted black bags.
vibrant plum bags contain 5 faded blue bags, 6 dotted black bags.
faded blue bags contain no other bags.
dotted black bags contain no other bags.''';

    final bags = rules.split('\n').map(day7.parseLine);
    final result = day7.possibleOptionsOutsideShinyGold(bags);
    expect(result, 4);
  });

  test('Day 7, part B', () {
    final rules = '''shiny gold bags contain 2 dark red bags.
dark red bags contain 2 dark orange bags.
dark orange bags contain 2 dark yellow bags.
dark yellow bags contain 2 dark green bags.
dark green bags contain 2 dark blue bags.
dark blue bags contain 2 dark violet bags.
dark violet bags contain no other bags.''';

    final bags = rules.split('\n').map(day7.parseLine);
    final result = day7.bagsInsideShinyGold(bags);
    expect(result, 126);
  });

  test('Day 8, part A', () {
    final input = '''nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6''';

    final result = day8.runUntilLoop(input);
    expect(result, 5);
  });

  test('Day 8, part B', () {
    final input = '''nop +0
acc +1
jmp +4
acc +3
jmp -3
acc -99
acc +1
jmp -4
acc +6''';

    final result = day8.runToHalt(input);
    expect(result, 8);
  });

  test('Day 9, part A & B', () {
    final numbers = [
      35,
      20,
      15,
      25,
      47,
      40,
      62,
      55,
      65,
      95,
      102,
      117,
      150,
      182,
      127,
      219,
      299,
      277,
      309,
      576
    ];
    final target = day9.firstIncorrect(numbers, preamble: 5);
    expect(target, 127);

    expect(day9.findContSum(numbers, target), 62);
  });

  test('Day 10, part A', () {
    final example1 = '16\n10\n15\n5\n1\n11\n7\n19\n6\n12\n4';
    expect(day10.joltDiff(example1), 7 * 5);

    final example2 =
        '28\n33\n18\n42\n31\n14\n46\n20\n48\n47\n24\n23\n49\n45\n19\n38\n39\n11\n1\n32\n25\n35\n8\n17\n7\n9\n4\n2\n34\n10\n3';
    expect(day10.joltDiff(example2), 22 * 10);
  });

  test('Day 10, part B', () {
    final example1 = '16\n10\n15\n5\n1\n11\n7\n19\n6\n12\n4';
    expect(day10.countOptions(example1), 8);

    final example2 =
        '28\n33\n18\n42\n31\n14\n46\n20\n48\n47\n24\n23\n49\n45\n19\n38\n39\n11\n1\n32\n25\n35\n8\n17\n7\n9\n4\n2\n34\n10\n3';
    expect(day10.countOptions(example2), 19208);
  });

  test('Day 11, part A & B', () {
    final input = '''L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL''';
    final gridA = day11.parseInput(input);
    expect(day11.runUntilStableA(gridA), 37);

    final gridB = day11.parseInput(input);
    expect(day11.runUntilStableB(gridB), 26);
  });
}
