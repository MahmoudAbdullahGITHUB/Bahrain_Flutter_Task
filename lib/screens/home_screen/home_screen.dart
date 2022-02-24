import 'dart:ui';

import 'package:bahrain_flutter_task/model/notes/response.dart';
import 'package:bahrain_flutter_task/screens/adding-note-screen/adding_note_screen.dart';
import 'package:bahrain_flutter_task/screens/home_screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/home_screen/cubit/states.dart';
import 'package:bahrain_flutter_task/screens/person_screen/person_screen.dart';
import 'package:bahrain_flutter_task/screens/settings-screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/settings-screen/setting_screen.dart';
import 'package:bahrain_flutter_task/screens/users-screen/users_screen.dart';
import 'package:bahrain_flutter_task/shared/constants/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_card.dart';

class HomeScreen extends StatefulWidget {
  static const routName = '/home-screen';

  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  List<NoteResponse>? myAllNotes = [];

  NotesGettingCubit? cubit;
  SettingsCubit? cubit2;
  // MySharedPreferences sharedPreferences = MySharedPreferences() ;

  @override
  Widget build(BuildContext context) {
    print('yes entered');
    // final GlobalKey<ScaffoldState> _scaffoldKey =
    //     GlobalKey<ScaffoldState>();
    return BlocConsumer<NotesGettingCubit, NotesGettingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        cubit = NotesGettingCubit.get(context);
        cubit2 = SettingsCubit.get(context);
        print('not again');
        if (state is ChangedToggleTest) {

          print('is that right or something else ${cubit2!.toggle}');
          cubit2!.toggle
              ? cubit!.getDataFromDatabase(cubit!.database,context)
              : cubit!.getNotesFromServer(context);
        }
        if (state is NoteGettingInitialState) {
          cubit2!.toggle
              ? cubit!.getDataFromDatabase(cubit!.database,context)
              : cubit!.getNotesFromServer(context);
        }
        if (state is NoteGettingSuccessState) {
          myAllNotes = state.notesResponseList;
          print('you make great ${myAllNotes?.length}');
        }
        if (state is NoteSearchingFillingState) {
          myAllNotes = state.notesResponseList;
          print('you make great ${myAllNotes?.length}');
        }
        if (state is NoteSearchingEmptyState) {
          myAllNotes = state.notesResponseList;
          print('you make great ${myAllNotes?.length}');
        }

        if(state is LoadingAgain){
          cubit2!.toggle
              ? cubit!.getDataFromDatabase(cubit!.database,context)
              : cubit!.getNotesFromServer(context);
        }

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text('Notes'),
            actions: [
              IconButton(
                icon: const Icon(Icons.person_add),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  print('${cubit2!.toggle}');
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ProfileScreen()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.settings),
                tooltip: 'Show Snackbar',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SettingScreen()));
                },
              ),
              IconButton(
                icon: const Icon(Icons.menu),
                tooltip: 'Show Snack bar',
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UsersScreen()));
                },
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => AddingNoteScreen())),
            child: const Icon(Icons.add),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
            child: Column(
              children: [
                SizedBox(
                  // color: Colors.red,
                  height: 60,
                  child: TextField(
                    controller: titleController,
                    decoration: const InputDecoration(
                        labelText: "Search",
                        hintText: "Search",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)))),
                    onChanged: (text) {
                      cubit!.searchingNotes(text);
                    },
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount:
                          myAllNotes!.isNotEmpty ? myAllNotes!.length : 0,
                      // itemCount: 0,
                      itemBuilder: (context, index) => Column(
                            children: [
                              ListTile(
                                leading: const Icon(Icons.list),
                                title: Text("${myAllNotes![index].text}"),
                              ),
                              const Divider(
                                color: Colors.grey,
                              )
                            ],
                          )),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
