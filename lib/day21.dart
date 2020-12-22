import 'package:aoc2020/common.dart';

const DAY = 21;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);
  final result = solveA(input);
  print('Sum of non allergenic ingridients: $result');
}

int solveA(String input) {
  final count = <String, int>{}; // ingridient - count
  final allerIngr = <String, Set<String>>{}; // allergen - ingridients

  _parseAndReduce(input, count, allerIngr);

  final allAllergens = <String>{};
  allerIngr.values.forEach((elements) {
    allAllergens.addAll(elements);
  });

  final nonAllergenic =
      count.entries.where((element) => !allAllergens.contains(element.key));
  final result = nonAllergenic
      .map((e) => e.value)
      .reduce((value, element) => value + element);
  return result;
}

void _parseAndReduce(
    String input, Map<String, int> count, Map<String, Set<String>> allerIngr) {
  final lines = input.split('\n');

  lines.forEach((line) {
    final blocks = line.split('(');
    final ingridients =
        blocks[0].split(' ').where((element) => element.isNotEmpty);
    final allergens = blocks[1]
        ?.split(RegExp(r'[\s,\)]'))
        ?.skip(1)
        ?.where((element) => element.isNotEmpty);

    ingridients.forEach((ingridient) {
      if (count[ingridient] == null) {
        count[ingridient] = 1;
      } else {
        count[ingridient]++;
      }
    });

    allergens.forEach((allergen) {
      if (allerIngr[allergen] == null) {
        allerIngr[allergen] = Set.from(ingridients);
      } else {
        allerIngr[allergen] =
            allerIngr[allergen].intersection(ingridients.toSet());
      }
      if (allerIngr[allergen].length == 1) {
        final ingr = allerIngr[allergen].first;
        allerIngr.forEach((key, value) {
          if (key != allergen) {
            value.remove(ingr);
          }
        });
      }
    });
  });

  assert(allerIngr.values.every((element) => element.length == 1));
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);
  final result = solveB(input);
  print('Result: \n$result\n');
}

String solveB(String input) {
  final count = <String, int>{}; // ingridient - count
  final allerIngr = <String, Set<String>>{}; // allergen - ingridients

  _parseAndReduce(input, count, allerIngr);

  final temp = allerIngr.entries.toList();
  temp.sort((a, b) => a.key.compareTo(b.key));

  final result = temp.map((e) => e.value.first).join(',');
  return result;
}
