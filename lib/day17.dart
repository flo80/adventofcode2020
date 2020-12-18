import 'package:aoc2020/common.dart';

const DAY = 17;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

class V {
  int x;
  int y;
  int z;

  V(this.x, this.y, this.z);

  @override
  bool operator ==(Object other) {
    if (other is V) {
      return other.x == x && other.y == y && other.z == z;
    }
    return false;
  }

  @override
  int get hashCode => 1000000 * x + 1000 * y + z;

  @override
  String toString() {
    return '($x, $y, $z)';
  }

  Iterable<V> neighbors() sync* {
    const offset = [-1, 0, 1];
    for (final a in offset) {
      for (final b in offset) {
        for (final c in offset) {
          if (a == 0 && b == 0 && c == 0) continue;
          yield V(x + a, y + b, z + c);
        }
      }
    }
  }
}

class V4 {
  int x;
  int y;
  int z;
  int w;

  V4(this.x, this.y, this.z, this.w);

  @override
  bool operator ==(Object other) {
    if (other is V4) {
      return other.x == x && other.y == y && other.z == z && other.w == w;
    }
    return false;
  }

  @override
  int get hashCode => 100000000 * w + 1000000 * x + 1000 * y + z;

  Iterable<V4> neighbors() sync* {
    const offset = [-1, 0, 1];
    for (final a in offset) {
      for (final b in offset) {
        for (final c in offset) {
          for (final d in offset) {
            if (a == 0 && b == 0 && c == 0 && d == 0) continue;
            yield V4(x + a, y + b, z + c, w + d);
          }
        }
      }
    }
  }
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);
  final result = solveA(input);
  print('Result: $result');
}

int solveA(String input) {
  final min = V(0, 0, 0);
  final max = V(0, 0, 0);

  Map<V, bool> grid = Map();

  input.split('\n').forEach((line) {
    max.y = 0;
    line.split('').forEach((element) {
      final v = V(max.x, max.y, 0);
      if (element == '#') grid[v] = true;
      max.y++;
    });
    max.x++;
  });

  for (var rounds = 1; rounds <= 6; rounds++) {
    min.x--;
    min.y--;
    min.z--;
    max.x++;
    max.y++;
    max.z++;

    final Map<V, bool> newGrid = new Map();

    for (var a = min.x; a <= max.x; a++) {
      for (var b = min.y; b <= max.y; b++) {
        for (var c = min.z; c <= max.z; c++) {
          final pos = V(a, b, c);
          final s = grid[pos] ?? false;
          final n = pos
              .neighbors()
              .map((p) => grid[p] ?? false)
              .fold(0, (prev, element) => element ? prev + 1 : prev);

          if (s && (n == 2 || n == 3)) {
            newGrid[pos] = true;
          }
          if (!s && n == 3) {
            newGrid[pos] = true;
          }
        }
      }
    }
    grid = newGrid;
  }

  final result =
      grid.values.fold(0, (prev, element) => element ? prev + 1 : prev);

  return result;
}

int solveB(String input) {
  final min = V4(0, 0, 0, 0);
  final max = V4(0, 0, 0, 0);

  Map<V4, bool> grid = Map();

  input.split('\n').forEach((line) {
    max.y = 0;
    line.split('').forEach((element) {
      final v = V4(max.x, max.y, 0, 0);
      if (element == '#') grid[v] = true;
      max.y++;
    });
    max.x++;
  });

  for (var rounds = 1; rounds <= 6; rounds++) {
    min.x--;
    min.y--;
    min.z--;
    min.w--;
    max.x++;
    max.y++;
    max.z++;
    max.w++;

    final Map<V4, bool> newGrid = new Map();

    for (var a = min.x; a <= max.x; a++) {
      for (var b = min.y; b <= max.y; b++) {
        for (var c = min.z; c <= max.z; c++) {
          for (var d = min.w; d <= max.w; d++) {
            final pos = V4(a, b, c, d);
            final s = grid[pos] ?? false;
            final n = pos
                .neighbors()
                .map((p) => grid[p] ?? false)
                .fold(0, (prev, element) => element ? prev + 1 : prev);

            if (s && (n == 2 || n == 3)) {
              newGrid[pos] = true;
            }
            if (!s && n == 3) {
              newGrid[pos] = true;
            }
          }
        }
      }
    }
    grid = newGrid;
  }

  final result =
      grid.values.fold(0, (prev, element) => element ? prev + 1 : prev);

  return result;
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);
  final result = solveB(input);
  print('Result: $result');
}
