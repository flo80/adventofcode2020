import 'dart:math';

import 'package:aoc2020/common.dart';

const DAY = 9;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY).split('\n').map(int.parse).toList();
  final result = firstIncorrect(input);
  print('Result: $result');
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY).split('\n').map(int.parse).toList();
  final target = firstIncorrect(input);
  final result = findContSum(input, target);
  print('Result: $result');
}

int firstIncorrect(List<int> numbers, {int preamble = 25}) {
  for (var i = preamble; i < numbers.length; i++) {
    final testNr = numbers[i];
    final testList = numbers.sublist(i - preamble, i);
    assert(testList.length == preamble);
    if (testList.any((element) => testList.contains(testNr - element))) {
      continue;
    }
    return testNr;
  }
  return null;
}

int findContSum(List<int> numbers, int target) {
  for (var i = 0; i < numbers.length; i++) {
    for (var l = 2; l < numbers.length - i; l++) {
      final sublist = numbers.sublist(i, i + l);
      final sum = sublist.reduce((a, b) => a + b);
      if (sum == target) {
        return sublist.reduce(min) + sublist.reduce(max);
      }
      if (sum > target) {
        break;
      }
    }
  }
  return null;
}
