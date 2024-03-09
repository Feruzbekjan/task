import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';
import 'package:uic_task/features/music/presentation/bloc/music_bloc.dart';

class MusicPage extends StatefulWidget {
  final int index;
  final AudioPlayer player;
  const MusicPage({
    Key? key,
    required this.index,
    required this.player,
  }) : super(key: key);

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  bool isPlaying = false;
  @override
  void initState() {
    widget.player.play();
    widget.player.playerStateStream.listen((event) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(builder: (context) {
        return Scaffold(
          body: BlocConsumer<MusicBloc, MusicState>(
            listener: (context, state) async {
              if (state.status == Status.upload) {
                await widget.player.setUrl(state.thisMusic!.source);
                widget.player.play();
              }
            },
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                            top: 100,
                          ),
                          height: 300,
                          width: 300,
                          clipBehavior: Clip.hardEdge,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            state.thisMusic!.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const Gap(20),
                        Text(
                          state.thisMusic!.title,
                        ),
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                        bottom: 30,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  context.read<MusicBloc>().add(ShuffleMusic());
                                },
                                child: state.isShuffle
                                    ? const Icon(
                                        Icons.shuffle,
                                        color: Colors.black,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.shuffle,
                                        color: Colors.grey,
                                        size: 30,
                                      ),
                              ),
                              
                              GestureDetector(
                                onTap: () {
                                  context.read<MusicBloc>().add(
                                        DownloadMusic(
                                          music: state.thisMusic!,
                                          download: (value) {
                                          },
                                        ),
                                      );
                                },
                                child: state.download? const CircularProgressIndicator(): const Icon(
                                  Icons.download,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                          const Gap(30),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  widget.player.stop();
                                  context.read<MusicBloc>().add(
                                        PrevoisMusic(
                                          index: state.index!,
                                        ),
                                      );
                                },
                                child: const Icon(
                                  Icons.arrow_left,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  await widget.player.setUrl(
                                    state.thisMusic!.source,
                                  );
                                  // ignore: use_build_context_synchronously
                                  context.read<MusicBloc>().add(
                                        PlayOrPause(
                                        
                                          play: state.isPlaying,
                                          isPlaying: () {
                                            widget.player.play();
                                          },
                                          isPaused: () {
                                            widget.player.pause();
                                          },
                                        ),
                                      );
                                },
                                child: state.isPlaying
                                    ? const Icon(Icons.pause)
                                    : const Icon(Icons.play_arrow),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  widget.player.pause();
                                  context.read<MusicBloc>().add(
                                        NextMusic(
                                          index: state.index!,
                                        ),
                                      );
                                  widget.player.play();
                                },
                                child: const Icon(
                                  Icons.arrow_right,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
