import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:m_tv/domain/usecases/search_tv.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvs searchTvs;

  TvSearchBloc({required this.searchTvs}) : super(StateEmptySearch()) {
    on<OnQueryChanged>((event, emit) async {
      emit(StateLoadingSearch());
      final result = await searchTvs.execute(event.query);
      result.fold(
        (failure) {
          emit(StateErrorSearch(message: failure.message));
        },
        (tvsData) {
          emit(StateHasData(result: tvsData));
        },
      );
    });
  }
}
