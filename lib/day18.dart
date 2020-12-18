import 'package:aoc2020/common.dart';

const DAY = 18;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);
  final lines = input.split('\n');
  final results = lines.map((line) => Solver(line).solve());
  final result = results.reduce((value, element) => value + element);
  print('Result: $result');
}

enum OP { plus, mult }

class Solver {
  String input;
  Iterator<String> iter;

  Solver(this.input) {
    iter = input.split('').iterator;
  }

  int solve() {
    var val;
    OP op;

    while (iter.moveNext()) {
      final curr = iter.current;
      if (curr == ' ') continue;

      var nr = int.tryParse(curr);
      if (curr == '*') {
        op = OP.mult;
      } else if (curr == '+') {
        op = OP.plus;
      } else if (curr == '(') {
        nr = solve();
      } else if (curr == ')') {
        return val;
      }

      if (nr != null) {
        if (op == null) {
          val = nr;
        } else {
          switch (op) {
            case OP.plus:
              val += nr;
              break;
            case OP.mult:
              val *= nr;
              break;
          }
        }
      }
    }
    return val;
  }

  int solveAdvanced() {
    // based on https://en.wikipedia.org/wiki/Operator-precedence_parser#Alternative_methods
    var newString = '((';
    while (iter.moveNext()) {
      final curr = iter.current;
      if (curr == ' ') continue;

      if (curr == '*') {
        newString += '))*((';
      } else if (curr == '+') {
        newString += ')+(';
      } else if (curr == '(') {
        newString += '(((';
      } else if (curr == ')') {
        newString += ')))';
      } else {
        newString += curr;
      }
    }
    newString += '))';
    input = newString;
    iter = newString.split('').iterator;
    return solve();
  }
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);
  final lines = input.split('\n');
  final results = lines.map((line) => Solver(line).solveAdvanced());
  final result = results.reduce((value, element) => value + element);
  print('Result: $result');
}
