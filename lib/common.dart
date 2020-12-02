import 'dart:io';

String loadFile(int day) {
  assert(day > 0 && day < 26);
  final path = "./inputs/day$day";
  final file = File(path);
  return file.readAsStringSync();
}
