import 'package:aoc2020/common.dart';

const DAY = 1;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);

  final numbers = input.split('\n').map((e) => int.parse(e));

  for (final a in numbers) {
    for (final b in numbers) {
      if (a + b == 2020) {
        print('Found $a + $b = ${a + b}');
        print('Solution $a * $b = ${a * b}');
        return;
      }
    }
  }
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);

  final numbers = input.split('\n').map((e) => int.parse(e));

  for (final a in numbers) {
    for (final b in numbers) {
      for (final c in numbers) {
        if (a + b + c == 2020) {
          print('Found $a + $b + $c = ${a + b + c}');
          print('Solution $a * $b * $c= ${a * b * c}');
          return;
        }
      }
    }
  }
}
