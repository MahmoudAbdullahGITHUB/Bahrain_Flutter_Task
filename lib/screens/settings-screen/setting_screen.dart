import 'package:bahrain_flutter_task/screens/settings-screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/settings-screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingScreen extends StatelessWidget {
  static const routName = '/setting-screen';
  bool isSwitch = true;

  SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SettingsCubit(),
        child: BlocConsumer<SettingsCubit, SettingsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            SettingsCubit cubit = SettingsCubit.get(context);

            return Scaffold(
                appBar: AppBar(
                  title: const Text('Settings'),
                ),
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: const EdgeInsets.all(8), // Border width
                    // decoration: const BoxDecoration(color: Colors.red),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Use Local Database',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                        Switch(
                          value: isSwitch,
                          onChanged: (value) {
                            isSwitch = value;
                          },
                          activeTrackColor: Colors.blueGrey,
                          activeColor: Colors.blue,
                        ),
                      ],
                    ),
                  ),
                ));
          },
        ));
  }
}
