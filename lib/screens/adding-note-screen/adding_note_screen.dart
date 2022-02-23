import 'package:another_flushbar/flushbar.dart';
import 'package:bahrain_flutter_task/screens/adding-note-screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/adding-note-screen/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddingNoteScreen extends StatelessWidget {
  static const routName = '/adding_note-screen';
  var titleController = TextEditingController();

  AddingNoteScreen({Key? key}) : super(key: key);
  AddingNoteCubit? cubit;



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AddingNoteCubit(),
        child: BlocConsumer<AddingNoteCubit, AddingNoteStates>(
          listener: (context, state) {},
          builder: (context, state) {
            cubit = AddingNoteCubit.get(context);

            if (state is AddingNoteSuccessState) {
              // ShowMessage(context);
            }

            return Scaffold(
                appBar: AppBar(title: const Text('Adding Notes'), actions: [
                  IconButton(
                    icon: const Icon(Icons.save),
                    tooltip: 'Show Snack bar',
                    onPressed: () {
                      // ShowMessage(context);
                      cubit!.cubitAddNote(
                          context: context,
                          text: titleController.text,
                          userId: "1",
                          placeDateTime: "2021-11-18T09:39:44");
                    },
                  ),
                ]),
                body: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 20.0, horizontal: 10),
                  child: TextField(
                    maxLines: 5,
                    controller: titleController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: "Note",
                        hintText: "Note",
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)))),
                  ),
                ));
          },
        ));
  }
}
