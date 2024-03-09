// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'music_bloc.dart';

class MusicEvent {}

class MusicBlocStarted extends MusicEvent {}

class SelectMusic extends MusicEvent {
  final int index;
  final MusicEntities music;
  final VoidCallback succsess;
  SelectMusic({
    required this.index,
    required this.music,
    required this.succsess,
  });
}

class NextMusic extends MusicEvent {
  final int index;
  bool? local;

  NextMusic({
    required this.index,
    this.local,
  });
}

class PrevoisMusic extends MusicEvent {
  final int index;
  bool? local;
  PrevoisMusic({
    required this.index,
    this.local,
  });
}

class PlayOrPause extends MusicEvent {
  final bool play;
  final VoidCallback isPlaying;
  final VoidCallback isPaused;
  PlayOrPause({
    required this.play,
    required this.isPlaying,
    required this.isPaused,
  });
}

class ShuffleMusic extends MusicEvent {}

class DownloadMusic extends MusicEvent {
  final MusicEntities music;
  final ValueChanged<String> download;
  DownloadMusic({
    required this.music,
    required this.download,
  });
}

class GetLocalMusic extends MusicEvent {}

class ProgresIndigator extends MusicEvent {
  final AudioPlayer player;
  ProgresIndigator({
    required this.player,
  });
}
