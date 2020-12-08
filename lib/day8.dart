import 'package:aoc2020/common.dart';

const DAY = 8;

void main([List<String> args, dynamic message]) {
  sp = message;

  partA();
  partB();
}

class Handheld {
  final List<String> instructions;
  int acc = 0;
  int ip = 0;

  Handheld(String input) : instructions = input.split('\n');

  void reset() {
    acc = 0;
    ip = 0;
  }

  bool singleStep() {
    final instr = instructions[ip].split(' ');
    final op = instr[0];
    final operand = int.parse(instr[1]);

    switch (op) {
      case 'nop':
        ip += 1;
        break;

      case 'jmp':
        ip += operand;
        break;

      case 'acc':
        acc += operand;
        ip += 1;
        break;

      default:
        throw Exception('Unknown $op');
    }

    return ip >= instructions.length;
  }

  bool runUntilLoop() {
    final seenIP = <int>{};

    do {
      seenIP.add(ip);
      if (singleStep()) return true;
    } while (!seenIP.contains(ip));

    return false;
  }
}

void partA() {
  printHeader(DAY, Part.A);
  final input = loadFile(DAY);
  final result = runUntilLoop(input);
  print('Acc before first loop: $result');
}

int runUntilLoop(String input) {
  final vm = Handheld(input);
  vm.runUntilLoop();
  final result = vm.acc;
  return result;
}

void partB() {
  printHeader(DAY, Part.B);
  final input = loadFile(DAY);
  final result = runToHalt(input);
  print('Acc after termination: $result');
}

int runToHalt(String input) {
  final vm = Handheld(input);
  var found = false;

  for (var i = 0; i < vm.instructions.length; i++) {
    final oldInstr = vm.instructions[i];
    var newInstr;
    if (oldInstr.startsWith('nop')) {
      newInstr = oldInstr.replaceFirst('nop', 'jmp');
    } else if (oldInstr.startsWith('jmp')) {
      newInstr = oldInstr.replaceFirst('jmp', 'nop');
    } else {
      newInstr = oldInstr;
    }

    if (oldInstr != newInstr) {
      vm.instructions[i] = newInstr;
    }

    vm.reset();
    final holds = vm.runUntilLoop();
    if (holds) {
      found = true;
      break;
    }
    vm.instructions[i] = oldInstr;
  }

  if (found) {
    return vm.acc;
  } else {
    return null;
  }
}
