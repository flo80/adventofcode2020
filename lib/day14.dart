import 'package:aoc2020/common.dart';

const DAY = 14;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);
  final result = solveA(input);
  print('Result: $result');
}

int solveA(String input) {
  final lines = input.split('\n');

  final mask = <int, bool>{};
  final memory = <int, int>{};

  lines.forEach((line) {
    if (line.startsWith('mask')) {
      mask.clear();
      final elements = line.substring(7).split('');
      for (var i = 0; i < elements.length; i++) {
        switch (elements[i]) {
          case '0':
            mask[35 - i] = false;
            break;
          case '1':
            mask[35 - i] = true;
            break;
          case 'X':
            break;
          default:
            throw Exception();
            break;
        }
      }
    } else if (line.startsWith('mem')) {
      final words = line.split(' ');
      var value = int.parse(words.last);
      final address =
          int.parse(words.first.substring(4, words.first.length - 1));

      for (final maskItem in mask.entries) {
        final bitmask = 1 << maskItem.key;
        value &= ~bitmask;
        if (maskItem.value) {
          value |= bitmask;
        }
      }
      memory[address] = value;
    } else {
      throw Exception();
    }
  });

  final result = memory.values.reduce((value, element) => value + element);
  return result;
}

int solveB(String input) {
  final lines = input.split('\n');

  final mask = <int, bool>{};
  final memory = <int, int>{};

  lines.forEach((line) {
    if (line.startsWith('mask')) {
      mask.clear();
      final elements = line.substring(7).split('');
      for (var i = 0; i < elements.length; i++) {
        switch (elements[i]) {
          case '0':
            mask[35 - i] = false;
            break;
          case '1':
            mask[35 - i] = true;
            break;
          case 'X':
            break;
          default:
            throw Exception();
            break;
        }
      }
    } else if (line.startsWith('mem')) {
      final words = line.split(' ');
      final value = int.parse(words.last);
      var address = int.parse(words.first.substring(4, words.first.length - 1));

      for (final maskItem in mask.entries) {
        if (maskItem.value) {
          final bitmask = 1 << maskItem.key;
          address &= ~bitmask;
          address |= bitmask;
        }
      }

      void fillAddress(int bit) {
        if (bit == 36) {
          memory[address] = value;
          return;
        }

        if (mask[bit] == null) {
          // fill once with zero
          address &= ~(1 << bit);
          fillAddress(bit + 1);
          // fill once with one
          address |= 1 << bit;
          fillAddress(bit + 1);
        } else {
          fillAddress(bit + 1);
        }
      }

      fillAddress(0);

      memory[address] = value;
    } else {
      throw Exception();
    }
  });

  final result = memory.values.reduce((value, element) => value + element);
  return result;
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);
  final result = solveB(input);
  print('Result: $result');
}
