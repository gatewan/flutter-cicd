import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:lib_core/domain/entities/tv.dart';
import 'package:lib_core/lib_core.dart';
import 'package:m_tv/domain/interface/tv_interface.dart';

class GetTvNowPlaying {
  final TvInterface interface;

  GetTvNowPlaying(this.interface);

  Future<Either<Failure, List<Tv>>> execute() {
    debugPrint('WTF: tv use case');
    return interface.getNowPlayingTvs();
  }
}
