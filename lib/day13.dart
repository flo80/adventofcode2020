import 'dart:math';

import 'package:aoc2020/common.dart';

const DAY = 13;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY).split('\n');
  final earliest = double.parse(input[0]);
  final options =
      input[1].split(',').where((element) => element != 'x').map(int.parse);

  var bestBus;
  var minTime;
  options.forEach((bus) {
    final delta = (earliest / bus).ceil() * bus - earliest;
    if (minTime == null || delta < minTime) {
      bestBus = bus;
      minTime = delta;
    }
    return delta;
  });

  final result = bestBus * minTime;
  print('Result: $result');
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY).split('\n');
  final options = input[1].split(',').map(int.tryParse).toList();

  mathematicalB(options);

  print('Iterative: ${iterateB(options)}');
}

void mathematicalB(List<int> options) {
  var question = <String>[];
  for (var i = 0; i < options.length; i++) {
    if (options[i] != null) {
      //  x * bus = ti
      //  ti - t  = i
      // => x * bus = t + i
      // => (t + i) mod bus = 0
      // => (t + i) mod options[i] = 0
      question.add('(t%2b$i)mod${options[i]}=0');
    }
  }

  print('http://www.wolframalpha.com/input?i=' + question.join(',') );
  final result = 226845233210288; //226845233210288 + 972831826422131 n
  print('=> Result: $result');
}

int iterateB(List<int> options) {
  final remainingBusses = options.where((element) => element != null).toList();

  var time = 0;
  var timeSteps = options[0];
  remainingBusses.remove(options[0]);

  while (remainingBusses.isNotEmpty) {
    final currentBus = remainingBusses.reduce(max);
    final busIndex = options.indexOf(currentBus);
    remainingBusses.remove(currentBus);

    // find next time when this bus works with current busses
    while ((time + busIndex) % currentBus != 0) {
      time += timeSteps;
    }

    // make sure, we only advance time in an interval which works for all busses
    timeSteps *= currentBus;
  }
  return time;
}
