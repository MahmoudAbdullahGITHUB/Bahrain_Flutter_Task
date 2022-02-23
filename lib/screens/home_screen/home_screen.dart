import 'dart:ui';

import 'package:bahrain_flutter_task/model/notes/response.dart';
import 'package:bahrain_flutter_task/screens/adding-note-screen/adding_note_screen.dart';
import 'package:bahrain_flutter_task/screens/home_screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/home_screen/cubit/states.dart';
import 'package:bahrain_flutter_task/screens/profile-screen/profile_screen.dart';
import 'package:bahrain_flutter_task/screens/settings-screen/setting_screen.dart';
import 'package:bahrain_flutter_task/screens/users-screen/users_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'category_card.dart';

class HomeScreen extends StatelessWidget {
  static const routName = '/home-screen';
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();

  HomeScreen({Key? key}) : super(key: key);
  List<NoteResponse>? myAllNotes = [];
  NotesGettingCubit? cubit;

  @override
  Widget build(BuildContext context) {
    // final GlobalKey<ScaffoldState> _scaffoldKey =
    //     GlobalKey<ScaffoldState>();
    return BlocProvider(
        create: (BuildContext context) => NotesGettingCubit(),
        child: BlocConsumer<NotesGettingCubit, NotesGettingStates>(
          listener: (context, state) {},
          builder: (context, state) {
            cubit = NotesGettingCubit.get(context);
            if (state is NoteGettingInitialState) {
              cubit!.getNotes();
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
            return Scaffold(
              key: scaffoldKey,
              appBar: AppBar(
                title: const Text('Notes'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.person_add),
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProfileScreen()));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.settings),
                    tooltip: 'Show Snackbar',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingScreen()));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.menu),
                    tooltip: 'Show Snack bar',
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UsersScreen()));
                    },
                  ),
                ],
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AddingNoteScreen())),
                child: const Icon(Icons.add),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
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
        ));
  }
}
