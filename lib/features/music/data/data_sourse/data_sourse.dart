import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uic_task/core/exseption/exseption.dart';
import 'package:uic_task/core/extension/extension.dart';
import 'package:uic_task/core/get_it/get_it.dart';
import 'package:uic_task/core/sql_singelton/singelton.dart';
import 'package:uic_task/features/music/data/model/music_model.dart';
import 'package:uic_task/features/music/domain/entities/music_entities.dart';

abstract class DataSourse {
  Future<List<MusicEntities>> getMusic();
  Future<bool> addDatabase(MusicEntities entities);
  Future<List<MusicEntities>> getLocalMusic();
  factory DataSourse() => _DataSourse();
}

class _DataSourse implements DataSourse {
  @override
  Future<List<MusicEntities>> getMusic() async {
    try {
      final dio = sl<Dio>();
      final response =
          await dio.get("https://storage.googleapis.com/uamp/catalog.json");
      final result = response.data["music"];
      final music = (result as List).map(
        (e) => MusicModel.fromJson(e),
      );
      return music.map((e) => e.toEntities).toList();
    } catch (e) {
      throw ServerException(
        errorMassege: "Xatolik",
        errorCode: "500",
      );
    }
  }

  @override
  Future<bool> addDatabase(
    MusicEntities entities,
  ) async {
    try {
      final dio = sl<Dio>();

      final directory = await getApplicationDocumentsDirectory();

      final fileName = entities.title;
      final lastIndex = entities.source.lastIndexOf(".") + 1;
      final trim = entities.source.substring(lastIndex);
      final path = "${directory.path}/$fileName.$trim";

      await dio.download(
        entities.source,
        path,
        onReceiveProgress: (count, total) {
          if (total != -1) {
            if ((count / total * 100) == 100) {}
          }
        },
      );

      final database = await StorageRepository.getInstanse();
      database.insert(
        "my_music",
        {
          "path": path,
          "title": entities.title,
          "album": entities.album,
          "artist": entities.artist,
          "genre": entities.genre,
          "source": entities.source,
          "image": entities.image,
          "trackNumber": entities.trackNumber,
          "totalTrackCount": entities.totalTrackCount,
          "duration": entities.duration,
          "site": entities.site,
        },
      );
      return true;
    } catch (e) {
      throw ServerException(
        errorMassege: "errorMassege",
        errorCode: "errorCode",
      );
    }
  }

  @override
  Future<List<MusicEntities>> getLocalMusic() async {
    try {
      final database = await StorageRepository.getInstanse();
      final List<MusicEntities> ls = [];
      final List<Map<String, dynamic>> rows =
          await database.query("my_music", columns: [
        "title",
        "album",
        "artist",
        "genre",
        "source",
        "image",
        "trackNumber",
        "totalTrackCount",
        "duration",
        "site",
        "path",
      ]);

      for (var row in rows) {
        final path = row["path"];
        final title = row["title"];
        final album = row["album"];
        final artist = row["artist"];
        final genre = row["genre"];
        final source = row['source'];
        final image = row['image'];
        final trackNumber = row['trackNumber'];
        final totalTrackCount = row["totalTrackCount"];
        final duration = row['duration'];
        final site = row['site'];
        ls.add(
          MusicEntities(
            path: path,
            title: title,
            album: album,
            artist: artist,
            genre: genre,
            source: source,
            image: image,
            trackNumber: trackNumber,
            totalTrackCount: totalTrackCount,
            duration: duration,
            site: site,
          ),
        );
      }
      return ls;
    } catch (e) {
      throw ServerException(
        errorMassege: "errorMassege",
        errorCode: "errorCode",
      );
    }
  }
}
