// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uic_task/core/either/either.dart';
import 'package:uic_task/core/failure/failure.dart';
import 'package:uic_task/features/music/data/data_sourse/data_sourse.dart';
import 'package:uic_task/features/music/domain/entities/music_entities.dart';
import 'package:uic_task/features/music/domain/repository/repository.dart';

class MusicRepositoryImpl implements MusicRepository {
  final DataSourse _dataSourse;
  MusicRepositoryImpl({
    required DataSourse dataSourse,
  }) : _dataSourse = dataSourse;
  @override
  Future<Either<Failure, List<MusicEntities>>> getMusic() async {
    try {
      final result = await _dataSourse.getMusic();
      return Right(result);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> downloadMusic(MusicEntities entities) async {
    try {
      final result = await _dataSourse.addDatabase(entities);
      return Right(result);
    } catch (e) {
      return Left(const ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<MusicEntities>>> getLocalMusic() async {
    try {
      final result = await _dataSourse.getLocalMusic();
      return Right(result);
    } catch (e) {
      return Left(
        const ServerFailure(),
      );
    }
  }
}
