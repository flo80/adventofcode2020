import 'package:aoc2020/common.dart';

const DAY = 15;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY).split(',').map(int.parse).toList();
  final result = solveA(input);
  print('Result: $result');
}

int solveA(List<int> seed, {int target = 2020}) {
  final numbers = <int, List<int>>{}; // number, rounds

  var lastNumber;
  for (var i = 0; i < seed.length; i++) {
    numbers[seed[i]] = [i];
    lastNumber = seed[i];
  }

  void add(int nr, int round) {
    if (numbers[nr] == null) {
      numbers[nr] = [round];
    } else {
      numbers[nr] = [round, numbers[nr][0]];
    }
  }

  for (var i = seed.length; i < target; i++) {
    var newNumber = 0;
    if (numbers[lastNumber] != null && numbers[lastNumber].length > 1) {
      newNumber = numbers[lastNumber][0] - numbers[lastNumber][1];
    }
    add(newNumber, i);
    lastNumber = newNumber;
  }

  return lastNumber;
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY).split(',').map(int.parse).toList();
  final result = solveA(input, target: 30000000);
  print('Result: $result');
}
