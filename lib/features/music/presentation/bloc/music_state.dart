
part of 'music_bloc.dart';

class MusicState {
  final bool isShuffle;
  final bool isPlaying;
  final int? index;
  final List<MusicEntities> music;
  final List<MusicEntities> localMusic;
  final MusicEntities? thisMusic;
  final Status status;
  final bool download;
   final Duration progres; 
  final Duration total; 
  final Duration buffer;
  MusicState({
    required this.isShuffle,
    required this.isPlaying,
    this.index,
    required this.music,
    required this.localMusic,
    this.thisMusic,
    required this.status,
    required this.download,
    required this.progres,
    required this.total,
    required this.buffer,
  });

  MusicState copyWith({
    bool? isShuffle,
    bool? isPlaying,
    int? index,
    List<MusicEntities>? music,
    List<MusicEntities>? localMusic,
    MusicEntities? thisMusic,
    Status? status,
    bool? download,
    Duration? progres,
    Duration? total,
    Duration? buffer,
  }) {
    return MusicState(
      isShuffle: isShuffle ?? this.isShuffle,
      isPlaying: isPlaying ?? this.isPlaying,
      index: index ?? this.index,
      music: music ?? this.music,
      localMusic: localMusic ?? this.localMusic,
      thisMusic: thisMusic ?? this.thisMusic,
      status: status ?? this.status,
      download: download ?? this.download,
      progres: progres ?? this.progres,
      total: total ?? this.total,
      buffer: buffer ?? this.buffer,
    );
  }

  @override
  String toString() {
    return 'MusicState(isShuffle: $isShuffle, isPlaying: $isPlaying, index: $index, music: $music, localMusic: $localMusic, thisMusic: $thisMusic, status: $status, download: $download, progres: $progres, total: $total, buffer: $buffer)';
  }

  @override
  bool operator ==(covariant MusicState other) {
    if (identical(this, other)) return true;
  
    return 
      other.isShuffle == isShuffle &&
      other.isPlaying == isPlaying &&
      other.index == index &&
      listEquals(other.music, music) &&
      listEquals(other.localMusic, localMusic) &&
      other.thisMusic == thisMusic &&
      other.status == status &&
      other.download == download &&
      other.progres == progres &&
      other.total == total &&
      other.buffer == buffer;
  }

  @override
  int get hashCode {
    return isShuffle.hashCode ^
      isPlaying.hashCode ^
      index.hashCode ^
      music.hashCode ^
      localMusic.hashCode ^
      thisMusic.hashCode ^
      status.hashCode ^
      download.hashCode ^
      progres.hashCode ^
      total.hashCode ^
      buffer.hashCode;
  }
}

enum Status {
  pure,
  loading,
  succsess,
  failure,
  upload
}
