import 'package:uic_task/core/either/either.dart';
import 'package:uic_task/core/failure/failure.dart';
import 'package:uic_task/features/music/domain/entities/music_entities.dart';

abstract class MusicRepository { 
  Future<Either<Failure, List<MusicEntities>>> getMusic();
  Future<Either<Failure, bool>> downloadMusic(MusicEntities entities );
  Future<Either<Failure, List<MusicEntities>>> getLocalMusic();
}