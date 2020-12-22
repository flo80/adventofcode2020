import 'package:aoc2020/common.dart';

const DAY = 22;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);
  final sum = solve(input);
  print('Sum: $sum');
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);
  final sum = solve(input, recursive: true);
  print('Sum: $sum');
}

int solve(String input, {bool recursive = false}) {
  final blocks = input.split('\n\n');
  var player1 = blocks.first.split('\n').skip(1).map(int.parse).toList();
  var player2 = blocks.last.split('\n').skip(1).map(int.parse).toList();
  if (recursive) {
    _playRecursiveGame(player1, player2);
  } else {
    _playRegularGame(player1, player2);
  }
  return _calcScore(player1, player2);
}

void _playRegularGame(List<int> player1, List<int> player2) {
  while (player1.isNotEmpty && player2.isNotEmpty) {
    final a = player1.removeAt(0);
    final b = player2.removeAt(0);
    if (a > b) {
      player1..add(a)..add(b);
    } else {
      player2..add(b)..add(a);
    }
  }
}

int _calcScore(List<int> player1, List<int> player2) {
  final winning = (player1.toList()..addAll(player2)).reversed.toList();
  var sum = 0;
  for (var i = 0; i < winning.length; i++) {
    sum += winning[i] * (i + 1);
  }
  return sum;
}

enum Player { P1, P2 }
Player _playRecursiveGame(List<int> player1, List<int> player2) {
  final seen = <int>[];

  while (player1.isNotEmpty && player2.isNotEmpty) {
    // 'hash'
    final s = _calcScore(player1, []) * 1000000 + _calcScore([], player2);
    if (seen.contains(s)) {
      return Player.P1;
    }
    seen.add(s);

    final a = player1.removeAt(0);
    final b = player2.removeAt(0);

    if (player1.length >= a && player2.length >= b) {
      final win =
          _playRecursiveGame(player1.sublist(0, a), player2.sublist(0, b));
      if (win == Player.P1) {
        player1..add(a)..add(b);
      } else {
        player2..add(b)..add(a);
      }
    } else {
      if (a > b) {
        player1..add(a)..add(b);
      } else {
        player2..add(b)..add(a);
      }
    }
  }

  if (player1.isEmpty) return Player.P2;
  return Player.P1;
}
