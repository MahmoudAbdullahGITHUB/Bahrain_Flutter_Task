import 'dart:async';
import 'dart:convert';

import 'package:bahrain_flutter_task/model/user/response.dart';
import 'package:bahrain_flutter_task/network/remote/dio_helper.dart';
import 'package:bahrain_flutter_task/screens/home_screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/home_screen/cubit/states.dart';
import 'package:bahrain_flutter_task/screens/settings-screen/cubit/states.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/states.dart';
import 'package:bahrain_flutter_task/shared/constants/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  SettingsCubit() : super(SettingsInitialState());

  static SettingsCubit get(context) => BlocProvider.of(context);

  bool toggle = false;
  NotesGettingCubit? cubit3;
  PersonGettingCubit? cubit4;

  void turnSwitch({required bool toggle, context}) {
    this.toggle = toggle;

    cubit3 = NotesGettingCubit.get(context);
    cubit4 = PersonGettingCubit.get(context);

    NotesGettingStates my = ChangedToggleTest();
    PersonGettingStates my2 = ChangedToggleTest2();
    cubit3!.emit(my);
    cubit4!.emit(my2);
    emit(SettingsChangeToggleState());
  }
}
