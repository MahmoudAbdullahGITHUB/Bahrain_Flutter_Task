import 'dart:async';
import 'dart:convert';

import 'package:bahrain_flutter_task/model/user/response.dart';
import 'package:bahrain_flutter_task/network/remote/dio_helper.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonGettingCubit extends Cubit<PersonGettingStates> {
  PersonGettingCubit() : super(PersonGettingInitialState());

  static PersonGettingCubit get(context) => BlocProvider.of(context);

  List<PersonResponse>? personsResponseList;

  void getPersons({
    String? token,
  }) {
    emit(PersonGettingLoadingState());
    DioHelper.getData2(path: ApiDataAndEndPoints.getPersonsUrl).then((value) {
      List<dynamic> myList = value.data;

      personsResponseList =
          myList.map((e) => PersonResponse.fromJson(e)).toList();

      print('${personsResponseList![0].username}');

      emit(PersonGettingSuccessState(personsResponseList!));
    }).catchError((error) {
      print('error $error');
      emit(PersonGettingErrorState(error.toString()));
    });
  }
}






/*

void getPersons({
     String? token,
  }) {
    emit(PersonGettingLoadingState());
    DioHelper.getPersons(path: ApiDataAndEndPoints.getPersonsUrl)
        .then((value) {
      List<dynamic> myList= value.data;
      // final List parsed = json.decode(value.toString());
      // List<PersonResponse>? responseModelList = TopTenUsersModelResponse.fromJson(parsed).list;

      var litt = myList.map((e) => PersonResponse.fromJson(e)).toList();
      List<PersonResponse>? personsResponseList = litt;

      // personsResponse = PersonResponse.fromJson(value.data[0]);
      // List<PersonResponse> list = myList.cast<PersonResponse>();
      // String data = json.decode(json.encode(value.toString()));
      //
      // List<PersonResponse> ee = data;
      // var data = jsonDecode(value.toString()).cast<PersonResponse>();
      print('${litt[0].username}');
      //
      // // personsResponse = value.data;
      // print('cscs ${myList[0]['username']}');

      // personsResponse = PersonResponse.fromJson(myMap[0]);
      //
      // print(personsResponse?.username);

      // emit(PersonGettingSuccessState(personsResponse));

    }).catchError((error) {
      print('error $error');
      emit(PersonGettingErrorState(error.toString()));
    });
  }


 */
