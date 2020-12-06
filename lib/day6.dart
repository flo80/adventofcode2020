import 'package:aoc2020/common.dart';

const DAY = 6;

void main([List<String> args, dynamic message]) {
  sp = message;
  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);

  final sum = input
      .split('\n\n')
      .map((group) => group.replaceAll('\n', '').codeUnits.toSet().length)
      .reduce((value, element) => value + element);
  print('Sum $sum');
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);

  final sum = input
      .split('\n\n')
      .map((group) => group
          .split('\n')
          .map((entry) => entry.codeUnits.toSet())
          .reduce((value, element) => value.intersection(element))
          .length)
      .reduce((value, element) => value + element);
  print('Sum $sum');
}
