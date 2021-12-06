import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/repositories/tv_repository.dart';
import 'package:lib_core/lib_core.dart';

class GetTvRecommendations {
  final TvRepository repository;

  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(id) {
    return repository.getTvRecommendations(id);
  }
}
