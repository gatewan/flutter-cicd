import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_tv/domain/interface/tv_interface.dart';

class GetTvTopRated {
  final TvInterface interface;

  GetTvTopRated(this.interface);

  Future<Either<Failure, List<Tv>>> execute() {
    return interface.getTopRatedTvs();
  }
}
