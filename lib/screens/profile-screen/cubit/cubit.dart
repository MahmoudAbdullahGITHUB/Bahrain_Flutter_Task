import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:bahrain_flutter_task/model/adding_user/request.dart';
import 'package:bahrain_flutter_task/model/user/response.dart';
import 'package:bahrain_flutter_task/network/remote/dio_helper.dart';
import 'package:bahrain_flutter_task/screens/profile-screen/cubit/states.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddingPersonCubit extends Cubit<AddingPersonStates> {
  AddingPersonCubit() : super(AddingPersonInitialState());

  static AddingPersonCubit get(context) => BlocProvider.of(context);

  void cubitAddPerson({
    @required String? email,
    @required String? intrestId,
    @required String? userName,
    @required String? password,
    required BuildContext context,
  }) {
    emit(AddingPersonLoadingState());

    AddingUserRequest addingRequest = AddingUserRequest(
        email: email,
        imageAsBase64: null,
        username: userName,
        password: password,
        intrestId: intrestId);

    dynamic toJsonMap = jsonEncode(addingRequest);

    DioHelper.postData2(
      path: ApiDataAndEndPoints.addUserUrl,
      data: toJsonMap,
    ).then((value) {
      print(value.data);

      ShowMessage2(context);
      // Map<String, dynamic> myMap = value.data;
      print('you make greatness bro =  ');

      emit(AddingPersonSuccessState());
    }).catchError((error) {
      print('error $error ');
      emit(AddingPersonErrorState(error.toString()));
    });
  }

  Future<void> ShowMessage2(context) async {
    return Flushbar(
      title: "Hey Ninja",
      message: "Added Successfully...",
      duration: const Duration(seconds: 3),
    ).show(context);
  }
}
