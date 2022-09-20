import 'dart:io';

/// For read responses json in path:
///
/// ```dart
/// File('test/fixtures/$name')
/// ````
String fixture(String name) => File('test/fixtures/$name').readAsStringSync();
