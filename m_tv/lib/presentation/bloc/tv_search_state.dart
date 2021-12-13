part of 'tv_search_bloc.dart';

abstract class TvSearchState extends Equatable {
  const TvSearchState();
}

class StateEmptySearch extends TvSearchState {
  @override
  List<Object?> get props => [];
}

class StateLoadingSearch extends TvSearchState {
  @override
  List<Object?> get props => [];
}

class StateErrorSearch extends TvSearchState {
  final String message;

  const StateErrorSearch({required this.message});

  @override
  List<Object?> get props => [message];
}

class StateHasData extends TvSearchState {
  final List<Tv> result;

  const StateHasData({required this.result});

  @override
  List<Object?> get props => [result];
}
