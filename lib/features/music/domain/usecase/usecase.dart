import 'package:uic_task/core/either/either.dart';
import 'package:uic_task/core/failure/failure.dart';
import 'package:uic_task/core/use_case/use_case.dart';
import 'package:uic_task/features/music/domain/entities/music_entities.dart';
import 'package:uic_task/features/music/domain/repository/repository.dart';

class MusicUseCase implements UseCase<List<MusicEntities>, NoParams> {
  final MusicRepository _repository;
  MusicUseCase({
    required MusicRepository repository,
  }) : _repository = repository;
  @override
  Future<Either<Failure, List<MusicEntities>>> call(NoParams param) async {
    if(param is GetNetworkMusic){
      return await _repository.getMusic();
    }else if(param is GetLocalMusicStorege){
      return await _repository.getLocalMusic();
    }else{
      throw UnimplementedError();
    }
    
  }
}

class GetNetworkMusic extends NoParams {}

class GetLocalMusicStorege extends NoParams {}
