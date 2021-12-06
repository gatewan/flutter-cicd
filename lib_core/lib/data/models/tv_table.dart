import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';

class TvTable extends Equatable {
  final int id;
  final String? name;
  final String? posterPath;
  final String? overview;
  final bool isMovie;

  TvTable({
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
        isMovie: tv.isMovie,
      );

  factory TvTable.fromMap(Map<String, dynamic> map) => TvTable(
        id: map['id'],
        name: map['name'],
        posterPath: map['posterPath'],
        overview: map['overview'],
        isMovie: map['is_movie'] ?? true,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'posterPath': posterPath,
        'overview': overview,
        'is_movie': 0,
      };

  Tv toEntity() => Tv.watchlist(
        id: id,
        overview: overview,
        posterPath: posterPath,
        name: name,
      );

  @override
  // TODO: implement props
  List<Object?> get props => [id, name, posterPath, overview];
}
