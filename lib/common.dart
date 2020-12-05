import 'dart:convert';
import 'dart:core';
import 'dart:core' as core;
import 'dart:io';

import 'dart:isolate';

String path(int day) {
  return './inputs/day$day';
}

String loadFile(int day) {
  assert(day > 0 && day < 26);
  final file = File(path(day));
  return file.readAsStringSync().trim();
}

Future<bool> checkAndDownload(int day) async {
  final file = File(path(day));
  if (file.existsSync()) {
    return Future.value(true);
  } else {
    return downloadFile(day);
  }
}

Future<bool> downloadFile(int day) async {
  final cookieF = File('./.cookie');
  if (!cookieF.existsSync()) {
    print('Cookie is missing, cannot download file');
    return false;
  }

  final cookie = cookieF.readAsStringSync();
  final url = Uri.parse('https://adventofcode.com/2020/day/$day/input');
  final request = await HttpClient().getUrl(url);
  request.cookies.add(Cookie('session', cookie));
  final response = await request.close();
  if (response.statusCode == 200) {
    final outputFile = File(path(day)).openWrite();
    if (outputFile == null) {
      print('Could not open file to write');
      return false;
    }

    await response.pipe(outputFile);
    return true;
  } else {
    print('Could not download file, status: ${response.statusCode}');
    response.transform(Utf8Decoder()).listen((event) => print(event));
    return false;
  }
}

enum Part { A, B }

void printHeader(int day, Part part) {
  final partS = part == Part.A ? 'A' : 'B';
  print('\n\x1B[1mDay $day - Part $partS\x1B[0m');
}

SendPort sp;

void print(String message) {
  if (sp != null) {
    sp.send(message);
  } else {
    core.print(message);
  }
}
