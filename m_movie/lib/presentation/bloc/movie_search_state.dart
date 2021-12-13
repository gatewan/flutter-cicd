part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();
}

class StateEmptySearch extends MovieSearchState {
  @override
  List<Object?> get props => [];
}

class StateLoadingSearch extends MovieSearchState {
  @override
  List<Object?> get props => [];
}

class StateErrorSearch extends MovieSearchState {
  final String message;

  const StateErrorSearch({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateHasData extends MovieSearchState {
  final List<Movie> result;

  const StateHasData({required this.result});

  @override
  List<Object?> get props => [result];
}
