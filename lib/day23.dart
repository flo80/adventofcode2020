import 'package:aoc2020/common.dart';

const DAY = 23;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  // partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final numbers = loadFile(DAY).split('').map(int.parse).toList();
  final result = solveA(numbers);
  print('Result: $result');
}

String solveA(List<int> numbers) {
  _playGame(numbers, 100);

  final oneIdx = numbers.indexOf(1);
  final result = numbers
      .followedBy(numbers)
      .skip(oneIdx + 1)
      .take(numbers.length - 1)
      .join('');

  return result;
}

void _playGame(List<int> numbers, int rounds) {
  final len = numbers.length;
  var curValIdx = 0;
  for (var round = 0; round < rounds; round++) {
    final currVal = numbers[curValIdx];
    final three =
        numbers.followedBy(numbers).skip(curValIdx + 1).take(3).toList();

    three.forEach((element) {
      numbers.remove(element);
    });

    var insertVal = currVal - 1;
    while (!numbers.contains(insertVal)) {
      insertVal--;
      if (insertVal < 1) {
        insertVal += len + 1;
      }
    }

    final insertPos = numbers.indexOf(insertVal) + 1;
    numbers.insertAll(insertPos, three);
    curValIdx = (numbers.indexOf(currVal) + 1) % len;
  }
}
