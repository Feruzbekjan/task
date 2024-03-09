// ignore_for_file: public_member_api_docs, sort_constructors_first
class MusicEntities {
  final String? path;
  final String title;
  final String album;
  final String artist;
  final String genre;
  final String source;
  final String image;
  final int trackNumber;
  final int totalTrackCount;
  final int duration;
  final String site;

  MusicEntities({
    this.path,
    required this.title,
    required this.album,
    required this.artist,
    required this.genre,
    required this.source,
    required this.image,
    required this.trackNumber,
    required this.totalTrackCount,
    required this.duration,
    required this.site,
  });

  @override
  String toString() {
    return 'MusicEntities(path: $path, title: $title, album: $album, artist: $artist, genre: $genre, source: $source, image: $image, trackNumber: $trackNumber, totalTrackCount: $totalTrackCount, duration: $duration, site: $site)';
  }

  
  
}
