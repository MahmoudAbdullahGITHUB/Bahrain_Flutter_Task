import 'package:bahrain_flutter_task/screens/profile-screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/profile-screen/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  static const routName = '/profile-screen';
  var titleController = TextEditingController();
  var titleController2 = TextEditingController();
  var titleController3 = TextEditingController();

  var imageUrl = 'https://upload.wikimedia.org/wikipedia/'
      'commons/thumb/2/2f/Alesso_profile.png/467px-Alesso_profile.png';

  ProfileScreen({Key? key}) : super(key: key);
  AddingPersonCubit? cubit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => AddingPersonCubit(),
        child: BlocConsumer<AddingPersonCubit, AddingPersonStates>(
          listener: (context, state) {},
          builder: (context, state) {
            cubit = AddingPersonCubit.get(context);

            if (state is AddingPersonSuccessState) {
              // ShowMessage(context);
            }
            return Scaffold(
                appBar: AppBar(
                  title: const Text('Adding Notes'),
                ),
                body: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 10),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8), // Border width
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(48),
                              child: Image.network(
                                imageUrl,
                                height: 150.0,
                                width: 100.0,
                              ),
                            ),
                          ),
                        ),
                        TextField(
                          controller: titleController,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              labelText: "User Name",
                              hintText: "User Name",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: titleController2,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              labelText: "Password",
                              hintText: "Password",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)))),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextField(
                          controller: titleController3,
                          keyboardType: TextInputType.text,
                          decoration: const InputDecoration(
                              labelText: "Email",
                              hintText: "Email",
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)))),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            // primary: KAppColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          onPressed: () {
                            cubit!.cubitAddPerson(
                                context: context,
                                userName: titleController.text,
                                password: titleController2.text,
                                email: titleController3.text,
                                intrestId: "1");
                          },
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 40, vertical: 11.5),
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}
