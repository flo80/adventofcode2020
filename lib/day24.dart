import 'package:aoc2020/common.dart';

const DAY = 24;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);
  final result = solveA(input);
  print('Black tiles: $result');
}

class Coord {
  final double x;
  final double y;

  Coord(this.x, this.y);

  @override
  bool operator ==(Object other) {
    if (other is Coord) {
      return other.x == x && other.y == y;
    }
    return false;
  }

  @override
  int get hashCode => (10000000 * x + 10 * y).toInt();

  Iterable<Coord> _neigbhors() sync* {
    const offsets = [
      [1, 0],
      [0.5, 0.5],
      [-0.5, 0.5],
      [-1, 0],
      [-0.5, -0.5],
      [0.5, -0.5]
    ];

    for (final o in offsets) {
      yield Coord(x + o[0], y + o[1]);
    }
  }
}

int solveA(String input) {
  final lines = input.split('\n');
  final tiles = _parseInput(lines);
  return tiles.values.where((element) => element).length;
}

Map<Coord, bool> _parseInput(List<String> lines) {
  final tiles = <Coord, bool>{};

  lines.forEach((line) {
    var x = 0.0;
    var y = 0.0;
    var offset = 0;

    while (offset < line.length) {
      // e, se, sw, w, nw, and ne
      if (line.startsWith('e', offset)) {
        x++;
        offset++;
      } else if (line.startsWith('se', offset)) {
        x += 0.5;
        y += 0.5;
        offset += 2;
      } else if (line.startsWith('sw', offset)) {
        x -= 0.5;
        y += 0.5;
        offset += 2;
      } else if (line.startsWith('w', offset)) {
        x--;
        offset++;
      } else if (line.startsWith('nw', offset)) {
        x -= 0.5;
        y -= 0.5;
        offset += 2;
      } else if (line.startsWith('ne', offset)) {
        x += 0.5;
        y -= 0.5;
        offset += 2;
      }
    }
    final c = Coord(x, y);
    tiles[c] = !(tiles[c] ?? false);
  });

  return tiles;
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);
  final result = solveB(input);
  print('Black tiles: $result');
}

int solveB(String input) {
  final lines = input.split('\n');
  final tiles = _parseInput(lines);

  for (var r = 0; r < 100; r++) {
    tiles.removeWhere((key, value) => !value); // remove white tiles

    final newTiles = <Coord, bool>{};
    final _whites = <Coord>{};

    tiles.forEach((coord, value) {
      assert(value);
      final _ns = coord._neigbhors();
      _whites.addAll(_ns.where((c) => !(tiles[c] ?? false)));
      final ncount = _ns.where((c) => tiles[c] ?? false).length;
      if (ncount == 1 || ncount == 2) {
        newTiles[coord] = true;
      }
    });
    _whites.forEach((coord) {
      assert(!(tiles[coord] ?? false));
      final _ns = coord._neigbhors();
      final ncount = _ns.where((element) => tiles[element] ?? false).length;
      if (ncount == 2) {
        newTiles[coord] = true;
      }
    });

    tiles.clear();
    tiles.addAll(newTiles);
  }

  return tiles.values.where((element) => element).length;
}
