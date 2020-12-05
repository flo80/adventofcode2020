import 'package:aoc2020/common.dart';

const DAY = 3;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);
  final count = countHits(input);
  print('Trees hit: $count');
}

int countHits(String input, [int right = 3, int down = 1]) {
  final lines = input.split('\n');

  final rows = lines.length;
  final columns = lines[1].length;

  var row = 0;
  var column = 0;
  var count = 0;
  while (row < rows) {
    final char = lines[row][column];
    if (char == '#') {
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
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);

  final count = countHitOptions(input);
  print('Hit Trees multiplied: $count');
}
