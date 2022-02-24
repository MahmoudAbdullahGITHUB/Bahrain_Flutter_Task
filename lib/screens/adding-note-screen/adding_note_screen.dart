import 'package:another_flushbar/flushbar.dart';
import 'package:bahrain_flutter_task/screens/adding-note-screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/adding-note-screen/cubit/states.dart';
import 'package:bahrain_flutter_task/screens/home_screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/settings-screen/cubit/cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddingNoteScreen extends StatelessWidget {
  static const routName = '/adding_note-screen';
  var titleController = TextEditingController();

  AddingNoteScreen({Key? key}) : super(key: key);
  AddingNoteCubit? cubit;
  SettingsCubit? cubit2;

  saveInServer(context) {
    cubit!.cubitAddNoteOnServer(
        context: context,
        text: titleController.text,
        userId: "1",
        placeDateTime: "2021-11-18T09:39:44");
  }

  saveInLocalDB(context) {
    cubit!.insertToDatabase(
        text: titleController.text,
        userId: "1",
        placeDateTime: "2021-11-18T09:39:44",
        context: context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddingNoteCubit, AddingNoteStates>(
      listener: (context, state) {},
      builder: (context, state) {
        cubit = AddingNoteCubit.get(context);
        cubit2 = SettingsCubit.get(context);

        return Scaffold(
            appBar: AppBar(title: const Text('Adding Notes'), actions: [
              IconButton(
                icon: const Icon(Icons.save),
                tooltip: 'Show Snack bar',
                onPressed: () {
                  print('boool = ${cubit2!.toggle}');
                  if (titleController.text.isNotEmpty) {
                    cubit2!.toggle
                        ? saveInLocalDB(context)
                        : saveInServer(context);
                  }
                },
              ),
            ]),
            body: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10),
              child: TextField(
                maxLines: 5,
                controller: titleController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: "Note",
                    hintText: "Note",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)))),
              ),
            ));
      },
    );
  }
}
