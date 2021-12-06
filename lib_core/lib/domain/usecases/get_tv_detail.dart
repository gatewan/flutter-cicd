import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';
import 'package:lib_core/domain/repositories/tv_repository.dart';
import 'package:lib_core/lib_core.dart';

class GetTvDetail {
  final TvRepository repository;

  GetTvDetail(this.repository);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return repository.getTvDetail(id);
  }
}
