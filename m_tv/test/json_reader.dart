import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('m_tv/test')) {
    dir = dir.replaceAll('m_tv/test', '');
  }
  return File('$dir/m_tv/test/$name').readAsStringSync();
}
