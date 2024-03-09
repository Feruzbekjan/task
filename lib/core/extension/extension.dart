import 'package:uic_task/features/music/data/model/music_model.dart';
import 'package:uic_task/features/music/domain/entities/music_entities.dart';

extension MusicModelEntities on MusicModel {
  MusicEntities get toEntities {
    return MusicEntities(
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
    );
  }
}
