part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class OnMovieDetail extends MovieDetailEvent {
  final int id;

  const OnMovieDetail({required this.id});

  @override
  List<Object?> get props => [id];
}
