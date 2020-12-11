import 'package:aoc2020/common.dart';

const DAY = 11;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

class Coord {
  final int x;
  final int y;

  Coord(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (other is Coord) {
      return other.x == x && other.y == y;
    }
    return false;
  }

  @override
  int get hashCode => 1000 * y + x;

  @override
  String toString() {
    return '($x,$y)';
  }
}

class Grid {
  final Map<Coord, State> seats;
  final int xs;
  final int ys;

  Grid(this.seats, this.xs, this.ys);

  @override
  String toString() {
    var output = '';
    for (var y = 0; y < ys; y++) {
      for (var x = 0; x < xs; x++) {
        final s = seats[Coord(x, y)];
        var c = ' ';
        if (s == State.Empty) c = 'L';
        if (s == State.Occupied) c = '#';
        if (s == State.Floor) c = '.';
        output = output + c;
      }
      output = output + '\n';
    }
    return output;
  }
}

enum State { Floor, Empty, Occupied }

Grid parseInput(String input) {
  final lines = input.split('\n');
  final data = <Coord, State>{};

  for (var y = 0; y < lines.length; y++) {
    final line = lines[y];
    for (var x = 0; x < line.length; x++) {
      final char = line.substring(x, x + 1);
      State s;
      switch (char) {
        case '#':
          s = State.Occupied;
          break;
        case 'L':
          s = State.Empty;
          break;
        default:
          s = State.Floor;
          break;
      }
      data[Coord(x, y)] = s;
    }
  }
  return Grid(data, lines[0].length, lines.length);
}

const _directions = [
  [-1, -1],
  [0, -1],
  [1, -1],
  [-1, 0],
  [1, 0],
  [-1, 1],
  [0, 1],
  [1, 1]
];

int neighborsA(Coord c, Grid grid) {
  final fields = _directions.map((e) => Coord(c.x + e[0], c.y + e[1]));

  return fields
      .map((e) => grid.seats[e] == State.Occupied ? 1 : 0)
      .reduce((value, element) => value + element);
}

int neighborsB(Coord c, Grid grid) {
  final fields = _directions.map((e) {
    for (var step = 1; step < 10000; step++) {
      final newCoord = Coord(c.x + e[0] * step, c.y + e[1] * step);
      final s = grid.seats[newCoord];
      if (s == null || s == State.Empty) return 0;
      if (s == State.Occupied) return 1;
    }
    throw Exception('Something went wrong or grid is too large');
  });
  return fields.reduce((value, element) => value + element);
}

bool advance(
    Grid grid, int Function(Coord, Grid) neighbors, int occupiedCount) {
  final newGrid = <Coord, State>{};
  newGrid.addAll(grid.seats);
  var didChange = false;

  for (var item
      in grid.seats.entries.where((element) => element.value != State.Floor)) {
    final neighborCount = neighbors(item.key, grid);
    switch (item.value) {
      case State.Empty:
        if (neighborCount == 0) {
          newGrid[item.key] = State.Occupied;
          didChange = true;
        }
        break;
      case State.Occupied:
        if (neighborCount >= occupiedCount) {
          newGrid[item.key] = State.Empty;
          didChange = true;
        }
        break;
      default:
        break;
    }
  }
  grid.seats.clear();
  grid.seats.addAll(newGrid);
  return didChange;
}

int runUntilStableA(Grid grid) {
  var changed = false;
  do {
    changed = advance(grid, neighborsA, 4);
  } while (changed);

  return grid.seats.values.where((element) => element == State.Occupied).length;
}

int runUntilStableB(Grid grid) {
  var changed = false;
  do {
    changed = advance(grid, neighborsB, 5);
  } while (changed);

  return grid.seats.values.where((element) => element == State.Occupied).length;
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);
  final grid = parseInput(input);
  final result = runUntilStableA(grid);
  print('Result: $result');
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);
  final grid = parseInput(input);
  final result = runUntilStableB(grid);
  print('Result: $result');
}
