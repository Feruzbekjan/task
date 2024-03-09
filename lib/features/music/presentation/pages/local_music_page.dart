import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:just_audio/just_audio.dart';

import 'package:uic_task/features/music/presentation/bloc/music_bloc.dart';

class MusicPageLocale extends StatefulWidget {
  final int index;
  final AudioPlayer player;
  const MusicPageLocale({
    Key? key,
    required this.index,
    required this.player,
  }) : super(key: key);

  @override
  State<MusicPageLocale> createState() => _MusicPageLocaleState();
}

class _MusicPageLocaleState extends State<MusicPageLocale> {
  // bool isPlaying = false;
  // Duration progress = Duration.zero;
  // Duration buffered = Duration.zero;
  // Duration total = Duration.zero;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Builder(
        builder: (context) {
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
                                  onTap: () async {
                                    context.read<MusicBloc>().add(
                                          ShuffleMusic(),
                                        );
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
                              ],
                            ),
                            const Gap(30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ElevatedButton(
                                  onPressed: () async {
                                    context.read<MusicBloc>().add(
                                          PrevoisMusic(
                                            local: true,
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
                                    context.read<MusicBloc>().add(
                                          NextMusic(
                                            index: state.index!,
                                            local: true,
                                          ),
                                        );
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
        },
      ),
    );
  }
}
