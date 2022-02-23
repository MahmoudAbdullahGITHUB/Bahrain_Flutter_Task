import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:bahrain_flutter_task/model/adding_note/request.dart';
import 'package:bahrain_flutter_task/model/user/response.dart';
import 'package:bahrain_flutter_task/network/remote/dio_helper.dart';
import 'package:bahrain_flutter_task/screens/adding-note-screen/cubit/states.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddingNoteCubit extends Cubit<AddingNoteStates> {
  AddingNoteCubit() : super(AddingNoteInitialState());

  static AddingNoteCubit get(context) => BlocProvider.of(context);

  // List<AddingResponse>? AddingsResponseList;

  // void cubitAddNote2({
  //   @required String? text,
  //   @required String? userId,
  //   @required String? placeDateTime,
  //   required BuildContext context,
  // }) {
  //   ShowMessage2(context);
  //   // emit(AddingNoteSuccessState());
  //
  //
  // }


  void cubitAddNote({
    @required String? text,
    @required String? userId,
    @required String? placeDateTime,
    required BuildContext context,

  }) {
    emit(AddingNoteLoadingState());

    AddingNoteRequest addingRequest = AddingNoteRequest(
      text: text,
      userId: userId,
      placeDateTime: placeDateTime,
    );
    // List<AddingRequest> list = [addingRequest];

    dynamic toJsonMap = jsonEncode(addingRequest);

    DioHelper.postData2(
      path: ApiDataAndEndPoints.addNoteUrl,
      data: toJsonMap,
    ).then((value) {
      print(value.data);

      ShowMessage2(context);
      // Map<String, dynamic> myMap = value.data;
      print('you make greatness bro =  ');

      emit(AddingNoteSuccessState());
    }).catchError((error) {
      print('error $error ');
      emit(AddingNoteErrorState(error.toString()));
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
