import 'package:bahrain_flutter_task/model/user/response.dart';
import 'package:bahrain_flutter_task/screens/settings-screen/cubit/cubit.dart';
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
  PersonGettingCubit? cubit;
  SettingsCubit? cubit2;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PersonGettingCubit, PersonGettingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        cubit = PersonGettingCubit.get(context);
        cubit2 = SettingsCubit.get(context);
        print('toggle in persons ${cubit2!.toggle}');
        if (state is ChangedToggleTest2) {
          print('is that right here or something else ${cubit2!.toggle}');
          cubit2!.toggle
              ? cubit!.getPersonFromDatabase(cubit!.database, context)
              : cubit!.getPersonsFromServer(context);
        }

        if (state is AppCreateDatabaseState2) {
          cubit2!.toggle
              ? cubit!.getPersonFromDatabase(cubit!.database, context)
              : cubit!.getPersonsFromServer(context);
        }
        if (state is PersonGettingSuccessState) {
          myAllPersons = state.personsResponseList;
          print('you make great persons ${myAllPersons?.length}');
          print('you make great name ${myAllPersons?[0].username}');
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('Users'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: state is PersonGettingLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
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
    );
  }
}
