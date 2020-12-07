import 'package:aoc2020/common.dart';

const DAY = 7;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);
  final bags = input.split('\n').map(parseLine);
  final result = possibleOptionsOutsideShinyGold(bags);
  print('Possible options: $result');
}

int possibleOptionsOutsideShinyGold(Iterable<Bag> bags,
    {String target = 'shiny gold'}) {
  final map = Map<String, Set<String>>();
  bags.forEach((bag) {
    bag.bags?.forEach((inside) {
      if (map[inside.color] == null) map[inside.color] = {};
      map[inside.color].add(bag.color);
    });
  });

  final options = <String>{};
  options.addAll(map[target]);
  var foundmore = false;
  do {
    foundmore = false;
    final newOptions = <String>{};
    options.forEach((element) {
      if (map[element] != null) newOptions.addAll(map[element]);
    });
    final old = options.length;
    options.addAll(newOptions);
    if (options.length > old) foundmore = true;
  } while (foundmore);

  final result = options.length;
  return result;
}

class _InsideBag {
  final String color;
  final int quantity;

  _InsideBag(this.color, this.quantity);

  @override
  String toString() {
    return '$quantity $color';
  }
}

class Bag {
  final String color;

  final List<_InsideBag> bags;

  Bag(this.color, this.bags);

  @override
  String toString() {
    final join = bags?.map((b) => b.toString())?.join(' ') ?? 'none';
    return '$color contain $join';
  }
}

Bag parseLine(String line) {
  final outsideRegex = RegExp(r'(\w+\s\w+\s)bags');
  final outsideColor = outsideRegex.matchAsPrefix(line).group(1).trim();

  final insideRegex = RegExp(r'(\d+)\s(\w+\s\w+\s)bags?');
  final m = insideRegex.allMatches(line); //.group(0);
  final bags = m
      ?.map((e) => _InsideBag(e.group(2).trim(), int.parse(e.group(1))))
      ?.toList();

  return Bag(outsideColor, bags);
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);
  final bags = input.split('\n').map(parseLine);
  final result = bagsInsideShinyGold(bags);
  print('Contained bags: $result');
}

int bagsInsideShinyGold(Iterable<Bag> bags, {String target = 'shiny gold'}) {
  final map = <String, Bag>{};
  bags.forEach((bag) {
    map[bag.color] = bag;
  });

  int replace(Bag bag) {
    if (bag.bags == null || bag.bags.isEmpty) {
      return 1;
    }

    // bag itself, one bag of each color plus everything inside
    return 1 +
        bag.bags
            .map((b) => b.quantity * replace(map[b.color]))
            .reduce((value, element) => value + element);
  }

  // don't count shiny gold bag
  final result = replace(map[target]) - 1;
  return result;
}
