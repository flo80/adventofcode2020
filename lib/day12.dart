import 'package:aoc2020/common.dart';

const DAY = 12;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

//
//         [0,1]
// [-1,0]  [0,0]  [1,0]
//         [0,-1]
//

enum Dir { N, E, S, W }

List<int> val(Dir x) {
  switch (x) {
    case Dir.E:
      return [1, 0];
    case Dir.N:
      return [0, 1];
    case Dir.W:
      return [-1, 0];
    case Dir.S:
      return [0, -1];
  }
}

Dir _l9(Dir x) {
  switch (x) {
    case Dir.E:
      return Dir.N;
    case Dir.N:
      return Dir.W;
    case Dir.W:
      return Dir.S;
    case Dir.S:
      return Dir.E;
  }
}

Dir _left(Dir dir, int value) {
  if (value == 90) return _l9(dir);
  if (value == 180) return _l9(_l9(dir));
  if (value == 270) return _l9(_l9(_l9(dir)));
}

Dir _right(Dir dir, int value) {
  return _left(dir, 360 - value);
}

class Ship {
  int x = 0;
  int y = 0;
  Dir dir = Dir.E;

  void processInstruction(String instruction) {
    final instr = instruction.substring(0, 1);
    final value = int.parse(instruction.substring(1));

    switch (instr) {
      case 'N':
        y += value;
        break;
      case 'S':
        y -= value;
        break;
      case 'E':
        x += value;
        break;
      case 'W':
        x -= value;
        break;

      case 'F':
        final d = val(dir);
        x += d[0] * value;
        y += d[1] * value;
        break;

      case 'L':
        dir = _left(dir, value);
        break;
      case 'R':
        dir = _right(dir, value);
        break;
      default:
        throw Exception();
    }
  }

  void move(String input) {
    final instr = input.split('\n');
    instr.forEach((element) {
      processInstruction(element);
    });
  }

  int get dist {
    return x.abs() + y.abs();
  }
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);
  final ship = Ship();
  ship.move(input);
  final result = ship.dist;
  print('Manhattan distance: $result');
}

class WaypointShip {
  int sx = 0;
  int sy = 0;

  int wx = 10;
  int wy = 1;

  void _turnl(int value) {
    if (value == 0) {
      return;
    }

    if (value == 180) {
      wx = -wx;
      wy = -wy;
      return;
    }

    if (value == 90) {
      final ty = wy;

      wy = wx;
      if (ty.isNegative) {
        wx = ty.abs();
      } else {
        wx = -ty;
      }
      return;
    }

    if (value == 270) {
      final tx = wx;

      wx = wy;
      if (tx.isNegative) {
        wy = tx.abs();
      } else {
        wy = -tx;
      }
    }
    return;
  }

  void processInstruction(String instruction) {
    final instr = instruction.substring(0, 1);
    final value = int.parse(instruction.substring(1));

    switch (instr) {
      case 'N':
        wy += value;
        break;
      case 'S':
        wy -= value;
        break;
      case 'E':
        wx += value;
        break;
      case 'W':
        wx -= value;
        break;

      case 'F':
        sx += wx * value;
        sy += wy * value;
        break;

      case 'L':
        _turnl(value);
        break;
      case 'R':
        _turnl(360 - value);
        break;
      default:
        throw Exception();
    }
  }

  void move(String input) {
    final instr = input.split('\n');
    instr.forEach((element) {
      processInstruction(element);
    });
  }

  int get dist {
    return sx.abs() + sy.abs();
  }

  @override
  String toString() {
    return 'S: ($sx, $sy) W: ($wx, $wy)';
  }
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);
  final ship = WaypointShip();
  ship.move(input);
  final result = ship.dist;
  print('Manhattan distance: $result');
}
