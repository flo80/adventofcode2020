import 'package:aoc2020/day2.dart' as day2;
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
}
