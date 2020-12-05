import 'dart:isolate';

import 'package:aoc2020/common.dart';

void main(List<String> arguments) {
  print('\x1B[1m\x1B[4mAdvent of Code 2020\x1B[0m');
  
  if (arguments.length == 1) {
    if (arguments[0] == 'all') {
        runAllDays();
    }
    else {
      final day = int.tryParse(arguments[0]);
      if (day != null) {
        print('Will run day $day');
        runDay(day);
      } else {
        print('Please provide day number as first argument');
      }
    }
  } else {
    final now = DateTime.now();
    if (now.year == 2020 && now.month == 12) {
      runDay(now.day);
    } else {
      runAllDays();
    }
  }
}

void runAllDays() async {
  var upto = 25;
  final now = DateTime.now();
  if (now.year == 2020 && now.month == 12) {
    upto = now.day;
  }
  for (var day = 1; day <= upto; day++) {
    await runDay(day);
  }
}

void runDay(int day) async {
  if (!await checkAndDownload(day)) {
    print(
        'Could get download input file for day $day, running will probably fail');
  }

  final uri = Uri(scheme: 'package', path: 'aoc2020/day$day.dart');
  Isolate iso;
  final rc = ReceivePort();
  rc.listen((message) {
    if (message == null) {
      rc.close();
    } else {
      print(message);
    }
  });
  try {
    iso = await Isolate.spawnUri(uri, [], rc.sendPort, onExit: rc.sendPort);
    if (iso == null) {
      throw Exception('Iso not found');
    }
  } catch (e) {
    print('Could not run Day $day');
    rc.close();
  }
}
