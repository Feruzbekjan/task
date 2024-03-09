import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:uic_task/features/music/presentation/bloc/music_bloc.dart';
import 'package:uic_task/features/music/presentation/pages/local_music_page.dart';
import 'package:uic_task/features/music/presentation/pages/music_page.dart';

class MusicScreen extends StatefulWidget {
  const MusicScreen({super.key});

  @override
  State<MusicScreen> createState() => _MusicScreenState();
}

class _MusicScreenState extends State<MusicScreen>
    with SingleTickerProviderStateMixin {
  late final AudioPlayer player;
  late PageController pageController;
  late TabController tabController;
  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    pageController = PageController();
    player = AudioPlayer();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return SafeArea(
        child: BlocBuilder<MusicBloc, MusicState>(
          builder: (context, state) {
            switch (state.status) {
              case Status.pure:
                context.read<MusicBloc>().add(MusicBlocStarted());
                return const Scaffold(body: SizedBox());
              case Status.loading:
                return const Scaffold(
                  body: Center(
                    child: CupertinoActivityIndicator(),
                  ),
                );
              case Status.failure:
                return const Scaffold(
                  body: Center(
                    child: Text("Xatolik boldi"),
                  ),
                );
              case Status.succsess || Status.upload:
                return Scaffold(
                  appBar: AppBar(
                    title: const Text("Music App"), 
                    centerTitle: true,
                    bottom: TabBar(controller: tabController, tabs: const [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Song",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Local",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Album"),
                      ),
                    ]),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                    ),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        ListView(
                          children: [
                            ...List.generate(
                              state.music.length,
                              (index) {
                                return GestureDetector(
                                  onTap: () async {
                                    await player.setUrl(
                                      state.music[index].source,
                                    );
                                    player.play();

                                    // ignore: use_build_context_synchronously
                                    context.read<MusicBloc>().add(
                                          SelectMusic(
                                            succsess: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MusicPage(
                                                    index: index,
                                                    player: player,
                                                  ),
                                                ),
                                              );
                                            },
                                            music: state.music[index],
                                            index: index,
                                          ),
                                        );
                                  },
                                  child: ListTile(
                                    leading: Container(
                                      height: 50,
                                      width: 50,
                                      clipBehavior: Clip.hardEdge,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Image.network(
                                        state.music[index].image,
                                        fit: BoxFit.cover,
                                        scale: 5,
                                      ),
                                    ),
                                    title: Text(state.music[index].title),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        ListView(
                          children: [
                            ...List.generate(state.localMusic.length, (index) {
                              return GestureDetector(
                                onTap: () async {
                                  await player.setAudioSource(AudioSource.file(
                                      state.localMusic[index].path!));
                                  player.play();
                                  // ignore: use_build_context_synchronously
                                  context.read<MusicBloc>().add(
                                        SelectMusic(
                                          index: index,
                                          music: state.localMusic[index],
                                          succsess: () {
                                            Navigator.of(context).push(
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    MusicPageLocale(
                                                  index: index,
                                                  player: player,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      );
                                },
                                child: ListTile(
                                  leading: Container(
                                    height: 50,
                                    width: 50,
                                    clipBehavior: Clip.hardEdge,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.network(
                                      state.localMusic[index].image,
                                      fit: BoxFit.cover,
                                      scale: 5,
                                    ),
                                  ),
                                  title: Text(state.localMusic[index].title),
                                ),
                              );
                            }),
                          ],
                        ),
                        Container(
                          width: 300,
                          height: 300,
                          color: Colors.amber,
                        ),
                      ],
                    ),
                  ),
                );
              default:
                return const Scaffold(body: SizedBox());
            }
          },
        ),
      );
    });
  }
}
