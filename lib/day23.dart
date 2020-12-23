import 'package:aoc2020/common.dart';

const DAY = 23;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final numbers = loadFile(DAY).split('').map(int.parse).toList();
  final result = solveA(numbers);
  print('Result: $result');
}

String solveA(List<int> numbers) {
  final links = _playGame(numbers, 100);

  var p = '';
  var c = links[1];
  do {
    p = p + c.toString();
    c = links[c];
  } while (c != 1);
  return p;
}

int solveB(List<int> numbers) {
  final links = _playGame(numbers, 10000000, size: 1000000);
  final first = links[1];
  final second = links[first];
  return first * second;
}

List<int> _playGame(List<int> numbers, int rounds, {int size}) {
  final len = size ?? numbers.length;

  final links = List.generate(len + 1, (index) => index + 1, growable: false);
  links.first = 0;
  links.last = 1;

  for (var i = 0; i < numbers.length; i++) {
    final curr = numbers[i];
    final pointsTo = numbers[(i + 1) % numbers.length];
    links[curr] = pointsTo;
  }
  if (len > numbers.length) {
    links[numbers.last] = numbers.length + 1;
    links[len] = numbers.first;
  }

  var currVal = numbers.first;
  for (var round = 0; round < rounds; round++) {
    // remember pickups so we can check if our insertion point is missing
    final pickedUpVals = [
      links[currVal],
      links[links[currVal]],
      links[links[links[currVal]]]
    ];
    final afterPickups = links[pickedUpVals.last];

    // skip pickup
    links[currVal] = afterPickups;

    var destination = currVal - 1;
    if (destination < 1) {
      destination += len;
    }
    while (pickedUpVals.contains(destination)) {
      destination--;
      if (destination < 1) {
        destination += len;
      }
    }

    links[pickedUpVals.last] = links[destination];
    links[destination] = pickedUpVals.first;

    currVal = links[currVal];
  }
  return links;
}

void _printCups(int currVal, List<int> links, {int count = 40}) {
  var p = '';
  var c = currVal;
  var i = 0;
  do {
    p = p + c.toString() + ' ';
    c = links[c];
    i++;
  } while (i < count && (c != currVal || c > links.length));
  print(p);
}

void partB() {
  printHeader(DAY, Part.B);
  final numbers = loadFile(DAY).split('').map(int.parse).toList();
  final result = solveB(numbers);
  print('Result: $result');
}
