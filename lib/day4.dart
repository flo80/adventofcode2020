import 'package:aoc2020/common.dart';

class Entry {
  final fields = Map<String, String>();
  final String input;

  Entry(this.input) {
    input.split(" ").forEach((element) {
      final data = element.split(":");
      fields[data[0]] = data[1];
    });
  }

  @override
  String toString() {
    return fields.toString();
  }
}

const requiredFields = {
  'byr',
  'iyr',
  'eyr',
  'hgt',
  'hcl',
  'ecl',
  'pid',
};
bool hasAllFields(Entry e) {
  return e.fields.keys.toSet().containsAll(requiredFields);
}

bool checkYearField(String entry, int min, int max) {
  if (entry.length < 4) return false;
  final number = int.parse(entry);
  return number >= min && number <= max;
}

bool checkHeight(String entry) {
  final unit = entry.substring(entry.length - 2);
  if (!(unit == "cm" || unit == "in")) return false;

  final number = int.parse(entry.substring(0, entry.length - 2));
  if (unit == "cm") {
    return number >= 150 && number <= 193;
  }
  return number >= 59 && number <= 76;
}

bool checkHairColor(String entry) {
  RegExp r = new RegExp(r"^\#[0-9a-f]{6}$");
  return r.hasMatch(entry);
}

bool checkEyeColor(String entry) {
  final allowed = {"amb", "blu", "brn", "gry", "grn", "hzl", "oth"};
  return allowed.contains(entry);
}

bool checkPid(String entry) {
  if (entry.length != 9) return false;
  final t = int.tryParse(entry);
  return null != t;
}

void partA() {
  print("\nDay 4 - Part A");

  final input = loadFile(4);

  Iterable<Entry> entries = parseEntries(input);
  int count = checkRequiredFields(entries);

  print("Valid entries: $count");
}

Iterable<Entry> parseEntries(String input) {
  final entries = input
      .split("\n\n")
      .map((e) => e.replaceAll("\n", " "))
      .map((e) => Entry(e));
  return entries;
}

int checkRequiredFields(Iterable<Entry> entries) {
  final count = entries.map(hasAllFields).where((element) => element).length;
  return count;
}

void partB() {
  print("\nDay 4 - Part B");

  final input = loadFile(4);

  Iterable<Entry> entries = parseEntries(input);
  int count = checkAllRequiredThings(entries);

  print("Valid entries: $count");
}

int checkAllRequiredThings(Iterable<Entry> entries) {
  bool isValid(Entry e) {
    return hasAllFields(e) &&
        checkYearField(e.fields["byr"], 1920, 2002) &&
        checkYearField(e.fields["iyr"], 2010, 2020) &&
        checkYearField(e.fields["eyr"], 2020, 2030) &&
        checkHeight(e.fields["hgt"]) &&
        checkHairColor(e.fields["hcl"]) &&
        checkEyeColor(e.fields["ecl"]) &&
        checkPid(e.fields["pid"]);
  }

  final count = entries.map(isValid).where((element) => element).length;
  return count;
}
