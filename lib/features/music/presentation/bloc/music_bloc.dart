import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uic_task/core/get_it/get_it.dart';
import 'dart:math';
import 'package:uic_task/features/music/domain/entities/music_entities.dart';
import 'package:flutter/foundation.dart';
import 'package:uic_task/features/music/domain/usecase/down_usecase.dart';
import 'package:uic_task/features/music/domain/usecase/usecase.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicBloc()
      : super(
          MusicState(
            buffer: Duration.zero,
            progres: Duration.zero,
            total: Duration.zero,
            localMusic: [],
            download: false,
            isShuffle: false,
            isPlaying: true,
            index: 0,
            music: [],
            status: Status.pure,
          ),
        ) {
    on<MusicBlocStarted>(
      (event, emit) async {
        emit(
          state.copyWith(
            status: Status.loading,
          ),
        );
      
        final usecase = sl<MusicUseCase>();
        final either = await usecase.call(GetNetworkMusic());
        either.either(
          (failure) {
            emit(
              state.copyWith(
                status: Status.failure,
              ),
            );
          },
          (value) {
            add(GetLocalMusic());
            emit(
              state.copyWith(
                thisMusic: value[0],
                music: value,
              ),
            );
          },
        );
      },
    );
    on<GetLocalMusic>((event, emit) async {
              final usecase = sl<MusicUseCase>();

      final either = await usecase.call(
        GetLocalMusicStorege(),
      );
      either.either(
        (failure) {},
        (value) {
          emit(
            state.copyWith(
              localMusic: value,
              status: Status.succsess,
            ),
          );
        },
      );
    });
    on<NextMusic>(
      (event, emit) async {
        if (event.local != true) {
          if (state.isShuffle == false) {
            if (event.index == state.music.length - 1) {
              emit(
                state.copyWith(
                  status: Status.upload,
                  index: 0,
                  thisMusic: state.music[0],
                ),
              );
            } else {
              emit(
                state.copyWith(
                  status: Status.upload,
                  index: event.index + 1,
                  thisMusic: state.music[event.index + 1],
                ),
              );
            }
          } else {
            final random = Random().nextInt(
              state.music.length,
            );
            emit(
              state.copyWith(
                status: Status.upload,
                thisMusic: state.music[random],
                index: random,
              ),
            );
          }
        } else {
          if (state.isShuffle != true) {
            if (event.index == state.localMusic.length - 1) {
              emit(
                state.copyWith(
                  status: Status.upload,
                  index: 0,
                  thisMusic: state.localMusic[0],
                ),
              );
            } else {
              emit(
                state.copyWith(
                  status: Status.upload,
                  index: event.index + 1,
                  thisMusic: state.localMusic[event.index + 1],
                ),
              );
            }
          } else {
            final random = Random().nextInt(
              state.localMusic.length,
            );
            emit(
              state.copyWith(
                status: Status.upload,
                thisMusic: state.localMusic[random],
                index: random,
              ),
            );
          }
        }
      },
    );
    on<PrevoisMusic>(
      (event, emit) {
        if (event.local != true) {
          if (state.isShuffle == false) {
            if (event.index == 0) {
              emit(
                state.copyWith(
                  status: Status.upload,
                  index: state.music.length - 1,
                  thisMusic: state.music[state.music.length - 1],
                ),
              );
            } else {
              emit(
                state.copyWith(
                  status: Status.upload,
                  index: event.index - 1,
                  thisMusic: state.music[event.index - 1],
                ),
              );
            }
          } else {
            final random = Random().nextInt(state.music.length);
            emit(
              state.copyWith(
                status: Status.upload,
                thisMusic: state.music[random],
                index: random,
              ),
            );
          }
        } else {
          //local
          if (state.isShuffle != true) {
            if (event.index == 0) {
              emit(
                state.copyWith(
                  index: state.localMusic.length - 1,
                  thisMusic: state.localMusic[state.localMusic.length - 1],
                ),
              );
            } else {
              emit(
                state.copyWith(
                  index: event.index - 1,
                  thisMusic: state.localMusic[event.index - 1],
                ),
              );
            }
          } else {
            final random = Random().nextInt(
              state.localMusic.length,
            );
            emit(
              state.copyWith(
                status: Status.upload,
                thisMusic: state.localMusic[random],
                index: random,
              ),
            );
          }
        }
      },
    );

    on<PlayOrPause>(
      (event, emit) {
        if (event.play) {
          emit(state.copyWith(
            status: Status.succsess,
            isPlaying: false,
          ));
          event.isPaused();
        } else {
          emit(
            state.copyWith(
              isPlaying: true,
              status: Status.upload,
            ),
          );
          event.isPlaying();
        }
      },
    );

    on<ShuffleMusic>(
      (event, emit) {
        emit(
          state.copyWith(
            isShuffle: !state.isShuffle,
          ),
        );
      },
    );

    on<SelectMusic>(
      (event, emit) async {
        final shared = await SharedPreferences.getInstance();
        final key = event.music.title;

        if (shared.getString(key) != null) {}
        emit(
          state.copyWith(
            isPlaying: true,
            status: Status.upload,
            index: event.index,
            thisMusic: event.music,
          ),
        );
        event.succsess();
      },
    );
    on<DownloadMusic>((event, emit) async {
      emit(
        state.copyWith(
          download: true,
        ),
      );
      
      final usecase = sl<DownloadMusicUseCase>();
      final either = await usecase.call(
        DownParam(
          entities: event.music,
        ),
      );
      either.either(
        (failure) {},
        (value) {
          add(GetLocalMusic());
          emit(
            state.copyWith(
              download: false,
            ),
          );
          event.download("$value");
        },
      );
    });
    on<ProgresIndigator>((event, emit) {
      event.player.bufferedPositionStream.listen((event) {
        emit(
          state.copyWith(
            buffer: event,
          ),
        );
      });
      event.player.positionStream.listen((event) {
        emit(
          state.copyWith(
            progres: event,
          ),
        );
      });
      event.player.durationStream.listen((event) {
        emit(
          state.copyWith(
            total: event,
          ),
        );
      });
    });

    //___________________________________________________
  }
}
