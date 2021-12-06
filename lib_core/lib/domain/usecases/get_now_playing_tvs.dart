import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/domain/repositories/tv_repository.dart';
import 'package:lib_core/lib_core.dart';

class GetNowPlayingTvs {
  final TvRepository repository;

  GetNowPlayingTvs(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    debugPrint('WTF: tv use case');
    return repository.getNowPlayingTvs();
  }
}
