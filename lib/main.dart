import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uic_task/core/get_it/get_it.dart';
import 'package:uic_task/core/sql_singelton/singelton.dart';
import 'package:uic_task/features/music/presentation/bloc/music_bloc.dart';
import 'package:uic_task/features/music/presentation/music_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageRepository.getInstanse();
  await getInjector();

  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {

    return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => MusicBloc())],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: MusicScreen(),
        // Scaffold(
        //   body: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       children: [
        //         GestureDetector(
        //           onTap: () async {
        //             final usecase = MusicUseCase(
        //                 repository:
        //                     MusicRepositoryImpl(dataSourse: DataSourse()));
        //             final either = await usecase.call(NoParams());
        //             either.either(
        //               (failure) {
        //                 print("FAILURE");
        //               },
        //               (value) async {
        //                 await player.setUrl(value[0].source);
        //                 print("KELDI");
        //                 player.play();
        //               },
        //             );
        //           },
        //           child: Text('Hello World!'),
        //         ),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }
}
