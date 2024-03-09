// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:uic_task/core/either/either.dart';
import 'package:uic_task/core/failure/failure.dart';
import 'package:uic_task/core/use_case/use_case.dart';
import 'package:uic_task/features/music/domain/entities/music_entities.dart';
import 'package:uic_task/features/music/domain/repository/repository.dart';

class DownloadMusicUseCase extends UseCase<bool, NoParams> {
  final MusicRepository _repository;
  DownloadMusicUseCase({
    required MusicRepository repository,
  }) : _repository = repository;

  @override
  Future<Either<Failure, bool>> call(NoParams param) async {
    if (param is DownParam) {
      return await _repository.downloadMusic(param.entities);
    }
    throw UnimplementedError();
  }
}

class DownParam extends NoParams {
  final MusicEntities entities;
  DownParam({
    required this.entities,
  });
}
