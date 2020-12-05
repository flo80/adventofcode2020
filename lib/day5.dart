import 'dart:math';

import 'package:aoc2020/common.dart';

const DAY = 5;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

int parseNr(String input) {
  final replaced = input
      .replaceAll('F', '0')
      .replaceAll('B', '1')
      .replaceAll('L', '0')
      .replaceAll('R', '1');
  final number = int.parse(replaced, radix: 2);
  return number;
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);

  final highest = input.split('\n').map(parseNr).reduce(max);
  print('Highest seat ID: $highest');
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);

  final maxVal = parseNr('BBBBBBBRRR');
  final allOptions = <int>{}..addAll(List.generate(maxVal, (index) => index));

  allOptions.removeAll(input.split('\n').map(parseNr));
  final killList = <int>[];

  for (var value in allOptions.toList()) {
    if (allOptions.contains(value - 1) || allOptions.contains(value + 1)) {
      killList.add(value);
    }
  }
  allOptions.removeAll(killList);

  assert(allOptions.length == 1);
  print('Seat: ${allOptions.first} ');
}
