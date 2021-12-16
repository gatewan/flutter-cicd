import 'dart:io';

String readJson(String name) {
  var dir = Directory.current.path;
  if (dir.endsWith('m_movie/test')) {
    dir = dir.replaceAll('m_movie/test', '');
  }
  return File('$dir/m_movie/test/$name').readAsStringSync();
}
