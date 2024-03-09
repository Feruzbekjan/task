import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:uic_task/features/music/data/data_sourse/data_sourse.dart';
import 'package:uic_task/features/music/data/repository/repository_Impl.dart';
import 'package:uic_task/features/music/domain/repository/repository.dart';
import 'package:uic_task/features/music/domain/usecase/down_usecase.dart';
import 'package:uic_task/features/music/domain/usecase/usecase.dart';

final sl = GetIt.instance;

Future<void> getInjector() async {
  sl.registerLazySingleton(
    () => Dio(),
  );
  usecaseMusic();
  downloadUsecase();
}

usecaseMusic() {
  sl
    ..registerFactory(() => MusicUseCase(
          repository: sl(),
        ))
    ..registerLazySingleton<MusicRepository>(
        () => MusicRepositoryImpl(dataSourse: sl()))
    ..registerLazySingleton(
      () => DataSourse(),
    );
}

downloadUsecase(){
  sl.registerFactory(() => DownloadMusicUseCase(repository: sl(),),);
}
