import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/repositories/tv_repository.dart';
import 'package:lib_core/lib_core.dart';

class GetWatchlistTvs {
  final TvRepository _repository;

  GetWatchlistTvs(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getWatchlistTvs();
  }
}
