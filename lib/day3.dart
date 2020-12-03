import 'package:aoc2020/common.dart';

void partA() {
  print("\nDay 3 - Part A");

  final input = loadFile(3);
  final count = countHits(input);
  print("Trees hit: $count");
}

int countHits(String input, [int right = 3, int down = 1]) {
  final lines = input.split("\n");

  final rows = lines.length;
  final columns = lines[1].length;

  int row = 0;
  int column = 0;
  int count = 0;
  while (row < rows) {
    final char = lines[row][column];
    if (char == "#") {
      count++;
    }
    row += down;
    column = (column + right) % columns;
  }
  return count;
}

int countHitOptions(String input) {
  final options = [
    [1, 1],
    [3, 1],
    [5, 1],
    [7, 1],
    [1, 2]
  ];

  final results =
      options.map((option) => countHits(input, option[0], option[1]));
  return results.fold(1, (previousValue, element) => previousValue * element);
}

void partB() {
  print("\nDay 3 - Part B");

  final input = loadFile(3);
  final count = countHitOptions(input);
  print("Hit Trees multiplied: $count");
}
