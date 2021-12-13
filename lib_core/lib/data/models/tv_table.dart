import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';

class TvTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;
  final bool isMovie;

  const TvTable({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.overview,
    required this.isMovie,
  });

  factory TvTable.fromEntity(TvDetail tv) => TvTable(
        id: tv.id,
        name: tv.name,
        posterPath: tv.posterPath,
        overview: tv.overview,
        isMovie: false,
      );

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
        id: map['id'],
        name: map['title'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        isMovie: map['is_movie'] == 1 ? true : false,
      );

  Tv toEntity() => Tv.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
        isMovie: isMovie,
      );

  @override
  List<Object?> get props => [id, name, posterPath, overview];
}
