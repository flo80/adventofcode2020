import 'package:aoc2020/common.dart';

const DAY = 16;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY).split('\n\n');

  final validNrs = parseValids(input[0]);
  final nrs = input.last
      .split('\n')
      .skip(1)
      .map((ticket) => ticket.split(',').map(int.parse))
      .expand((element) => element);

  final result = nrs
      .where((element) => !validNrs.contains(element))
      .reduce((value, element) => value + element);
  print('Result: $result');
}

Set<int> parseValids(String input) {
  final numbers = <int>{};
  final entries = input.split('\n');

  entries.forEach((line) {
    final ranges = line.split(':')[1].split('or');

    ranges.forEach((range) {
      final nrs = range.split('-');
      final min = int.parse(nrs[0]);
      final max = int.parse(nrs[1]);

      for (var i = min; i <= max; i++) {
        numbers.add(i);
      }
    });
  });
  return numbers;
}

Map<String, Set<int>> parseRules(String input) {
  final rules = <String, Set<int>>{};
  final entries = input.split('\n');

  entries.forEach((line) {
    final blocks = line.split(':');
    final type = blocks[0];
    final ranges = blocks[1].split('or');
    rules[type] = {};

    ranges.forEach((range) {
      final nrs = range.split('-');
      final min = int.parse(nrs[0]);
      final max = int.parse(nrs[1]);

      for (var i = min; i <= max; i++) {
        rules[type].add(i);
      }
    });
  });
  return rules;
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY).split('\n\n');

  final rules = parseRules(input[0]);
  final validNrs = parseValids(input[0]);
  final nrFields = input[0].split('\n').length;

  final validTickets = input.last
      .split('\n')
      .skip(1)
      .map((ticket) => ticket.split(',').map(int.parse).toList())
      .where((ticket) => !ticket.any((value) => !validNrs.contains(value)))
      .toList();

  // build up options per field
  List<Set<String>> options = List.generate(nrFields, (_) => {});
  for (var i = 0; i < nrFields; i++) {
    for (final ticket in validTickets) {
      final nr = ticket[i];
      final o = rules.entries
          .where((element) => element.value.contains(nr))
          .map((e) => e.key)
          .toSet();
      options[i].addAll(o);
      if (options[i].length == nrFields) {
        break;
      }
    }
  }

  // remove options where a number in a field is not possible
  for (var i = 0; i < nrFields; i++) {
    for (final ticket in validTickets) {
      final nr = ticket[i];
      final fieldsWithoutNr = rules.entries
          .where((element) => !element.value.contains(nr))
          .map((e) => e.key);
      options[i].removeAll(fieldsWithoutNr);
    }
  }

  // map names
  final names = List<String>(nrFields);
  while (options.any((element) => element.isNotEmpty)) {
    for (var i = 0; i < nrFields; i++) {
      if (options[i].length == 1) {
        final f = options[i].first;
        names[i] = f;
        options.forEach((element) {
          element.remove(f);
        });
        break;
      }
    }
  }

  final myTicket = input[1].split('\n')[1].split(',').map(int.parse).toList();

  var result = 1;
  for (var i = 0; i < nrFields; i++) {
    if (names[i].startsWith('departure')) {
      result *= myTicket[i];
    }
  }

  print('Result: $result');
}
