import 'package:aoc2020/common.dart';

void partA() {
  print("\nDay 2 - Part A");

  final input = loadFile(2);
  final lines = input.split("\n");
  final results = lines.map(isValidLine_A);
  final count = results.where((element) => element).length;
  print("Correct pws: $count");
}

void partB() {
  print("\nDay 2 - Part B");

  final input = loadFile(2);
  final lines = input.split("\n");
  final results = lines.map(isValidLine_B);
  final count = results.where((element) => element).length;
  print("Correct pws: $count");
}

bool isValidLine_A(String line) {
  final tokens = line.split(" ");
  final range = tokens.first.split("-");
  final char = tokens[1].substring(0, tokens[1].length - 1);
  final pw = tokens.last;

  final min = int.parse(range.first);
  final max = int.parse(range.last);

  int count = 0;
  for (final letter in pw.split('')) {
    if (letter == char) {
      count++;
    }
  }

  return count >= min && count <= max;
}

bool isValidLine_B(String line) {
  final tokens = line.split(" ");
  final range = tokens.first.split("-");
  final char = tokens[1].substring(0, tokens[1].length - 1);
  final pw = tokens.last;

  final posOne = int.parse(range.first);
  final posTwo = int.parse(range.last);

  int count = 0;
  if (pw[posOne - 1] == char) count++;
  if (pw[posTwo - 1] == char) count++;

  return count == 1;
}
