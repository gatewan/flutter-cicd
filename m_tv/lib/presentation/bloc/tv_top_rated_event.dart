part of 'tv_top_rated_bloc.dart';

abstract class TvTopRatedEvent extends Equatable {
  const TvTopRatedEvent();
}

class OnTvTopRated extends TvTopRatedEvent {
  const OnTvTopRated();

  @override
  List<Object?> get props => [];
}
