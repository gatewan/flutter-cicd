import 'package:flutter/foundation.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/usecases/get_top_rated_tvs.dart';
import 'package:lib_core/lib_core.dart';

class TopRatedTvsNotifier extends ChangeNotifier {
  final GetTopRatedTvs getTopRatedTvs;

  TopRatedTvsNotifier({required this.getTopRatedTvs});

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<Tv> _tvs = [];

  List<Tv> get tvs => _tvs;

  String _message = '';

  String get message => _message;

  Future<void> fetchTopRatedTvs() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTopRatedTvs.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (tvsData) {
        _tvs = tvsData;
        _state = RequestState.loaded;
        notifyListeners();
      },
    );
  }
}
