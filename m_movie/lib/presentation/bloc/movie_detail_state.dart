part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();
}

class StateEmptyDetail extends MovieDetailState {
  @override
  List<Object?> get props => [];
}

class StateLoadingDetail extends MovieDetailState {
  @override
  List<Object?> get props => [];
}

class StateErrorDetail extends MovieDetailState {
  final String message;

  const StateErrorDetail({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateMovieDetail extends MovieDetailState {
  final MovieDetail movieDetail;

  const StateMovieDetail({required this.movieDetail});

  @override
  List<Object?> get props => [movieDetail];
}
