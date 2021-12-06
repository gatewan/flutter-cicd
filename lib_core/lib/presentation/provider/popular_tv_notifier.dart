import 'package:flutter/foundation.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/usecases/get_popular_tvs.dart';
import 'package:lib_core/lib_core.dart';

class PopularTvsNotifier extends ChangeNotifier {
  final GetPopularTvs getPopularTvs;

  PopularTvsNotifier(this.getPopularTvs);

  RequestState _state = RequestState.empty;

  RequestState get state => _state;

  List<Tv> _tvs = [];

  List<Tv> get tvs => _tvs;

  String _message = '';

  String get message => _message;

  Future<void> fetchPopularTvs() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getPopularTvs.execute();

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
