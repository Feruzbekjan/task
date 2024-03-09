import 'package:json_annotation/json_annotation.dart';

part 'music_model.g.dart';
@JsonSerializable()
class MusicModel {
    @JsonKey(name: "id")
    String id;
    @JsonKey(name: "title")
    String title;
    @JsonKey(name: "album")
    String album;
    @JsonKey(name: "artist")
    String artist;
    @JsonKey(name: "genre")
    String genre;
    @JsonKey(name: "source")
    String source;
    @JsonKey(name: "image")
    String image;
    @JsonKey(name: "trackNumber")
    int trackNumber;
    @JsonKey(name: "totalTrackCount")
    int totalTrackCount;
    @JsonKey(name: "duration")
    int duration;
    @JsonKey(name: "site")
    String site;

    MusicModel({
        required this.id,
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

    MusicModel copyWith({
        String? id,
        String? title,
        String? album,
        String? artist,
        String? genre,
        String? source,
        String? image,
        int? trackNumber,
        int? totalTrackCount,
        int? duration,
        String? site,
    }) => 
        MusicModel(
            id: id ?? this.id,
            title: title ?? this.title,
            album: album ?? this.album,
            artist: artist ?? this.artist,
            genre: genre ?? this.genre,
            source: source ?? this.source,
            image: image ?? this.image,
            trackNumber: trackNumber ?? this.trackNumber,
            totalTrackCount: totalTrackCount ?? this.totalTrackCount,
            duration: duration ?? this.duration,
            site: site ?? this.site,
        );

    factory MusicModel.fromJson(Map<String, dynamic> json) => _$MusicModelFromJson(json);

    Map<String, dynamic> toJson() => _$MusicModelToJson(this);
}
