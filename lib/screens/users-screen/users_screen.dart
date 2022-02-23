import 'package:bahrain_flutter_task/model/user/response.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  static const routName = '/user-screen';
  bool isSwitch = true;

  UsersScreen({Key? key}) : super(key: key);
  List<PersonResponse>? myAllPersons = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => PersonGettingCubit(),
        child: BlocConsumer<PersonGettingCubit, PersonGettingStates>(
          listener: (context, state) {},
          builder: (context, state) {
            PersonGettingCubit cubit = PersonGettingCubit.get(context);
            if (state is PersonGettingInitialState) {
              cubit.getPersons();
            }
            if (state is PersonGettingSuccessState) {
              myAllPersons = state.personsResponseList;
              print('you make great ${myAllPersons?.length}');
            }
            return Scaffold(
              appBar: AppBar(
                title: const Text('Users'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    // itemCount: myAllNotes!.isNotEmpty ? myAllNotes!.length : 0,
                    itemCount:
                        myAllPersons!.isNotEmpty ? myAllPersons!.length : 0,
                    itemBuilder: (context, index) => Column(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.list),
                              title: Text("${myAllPersons![index].username}"),
                            ),
                            const Divider(
                              color: Colors.grey,
                            )
                          ],
                        )),
              ),
            );
          },
        ));
  }
}
