import 'package:aoc2020/common.dart';

const DAY = 10;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);

  final result = joltDiff(input);

  print('Result: $result');
}

int joltDiff(String input) {
  final values = input.split('\n').map(int.parse).toList()..sort();
  var comp = 0;
  var ones = 0;
  var threes = 0;
  for (var nr in values) {
    if (nr - comp == 1) {
      ones++;
    } else if (nr - comp == 3) {
      threes++;
    } else if (nr - comp > 3) {
      throw Exception();
    }
    comp = nr;
  }
  // device
  threes++;
  return ones * threes;
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);

  final result = countOptions(input);

  print('Result: $result');
}

int countOptions(String input) {
  final values = input.split('\n').map(int.parse).toList()..sort();
  final target = values.last + 3;
  values.add(values.last + 3); // add target value

  final options = <int, int>{};
  options[0] = 1;

  for (var val in values) {
    options[val] = (options[val - 3] ?? 0) +
        (options[val - 2] ?? 0) +
        (options[val - 1] ?? 0);
  }

  return options[target];
}
