import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('lib_core/test')) {
    dir = dir.replaceAll('lib_core/test', '');
  }
  return File('$dir/lib_core/test/$name').readAsStringSync();
}
