part of 'tv_search_bloc.dart';

abstract class TvSearchEvent extends Equatable {
  const TvSearchEvent();
}

class OnQueryChanged extends TvSearchEvent {
  final String query;

  const OnQueryChanged({required this.query});

  @override
  List<Object?> get props => [query];
}
