import 'package:aoc2020/day2.dart' as day2;
import 'package:aoc2020/day3.dart' as day3;
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
}
