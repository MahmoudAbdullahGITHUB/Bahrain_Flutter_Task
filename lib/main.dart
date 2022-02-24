import 'package:bahrain_flutter_task/screens/adding-note-screen/adding_note_screen.dart';
import 'package:bahrain_flutter_task/screens/adding-note-screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/home_screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/home_screen/home_screen.dart';
import 'package:bahrain_flutter_task/screens/person_screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/person_screen/person_screen.dart';
import 'package:bahrain_flutter_task/screens/settings-screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/settings-screen/setting_screen.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/users-screen/users_screen.dart';
import 'package:bahrain_flutter_task/shared/constants/bloc_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'network/remote/dio_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  /** this below lines only to see the current state of your bloc*/
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              NotesGettingCubit()..createDatabase(),
        ),
        BlocProvider(
          create: (BuildContext context) => SettingsCubit(),
          // create: (BuildContext context) => SettingsCubit()..turnSwitch(toggle: false),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              AddingPersonCubit()..createDatabase(),
        ),
        BlocProvider(
          create: (BuildContext context) => AddingNoteCubit()..createDatabase(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              PersonGettingCubit()..createDatabase(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomeScreen(),
        routes: {
          HomeScreen.routName: (_) => HomeScreen(),
          AddingNoteScreen.routName: (_) => AddingNoteScreen(),
          ProfileScreen.routName: (_) => ProfileScreen(),
          SettingScreen.routName: (_) => SettingScreen(),
          UsersScreen.routName: (_) => UsersScreen(),
        },
      ),
    );
  }
}
