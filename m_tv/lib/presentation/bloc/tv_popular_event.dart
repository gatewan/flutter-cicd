part of 'tv_popular_bloc.dart';

abstract class TvPopularEvent extends Equatable {
  const TvPopularEvent();
}

class OnTvPopular extends TvPopularEvent {
  const OnTvPopular();

  @override
  List<Object?> get props => [];
}
