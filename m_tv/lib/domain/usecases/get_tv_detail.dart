import 'package:dartz/dartz.dart';
import 'package:lib_core/domain/entities/tv_detail.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_tv/domain/interface/tv_interface.dart';

class GetTvDetail {
  final TvInterface interface;

  GetTvDetail(this.interface);

  Future<Either<Failure, TvDetail>> execute(int id) {
    return interface.getTvDetail(id);
  }
}
