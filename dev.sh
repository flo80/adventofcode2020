#!/bin/bash
dart run lib/day$1.dart
echo "Watching file"
fswatch lib/day$1.dart | xargs -n1 dart run