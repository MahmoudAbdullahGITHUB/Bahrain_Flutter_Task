import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:bahrain_flutter_task/model/user/response.dart';
import 'package:bahrain_flutter_task/network/remote/dio_helper.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class PersonGettingCubit extends Cubit<PersonGettingStates> {
  PersonGettingCubit() : super(PersonGettingInitialState());

  static PersonGettingCubit get(context) => BlocProvider.of(context);

  List<PersonResponse>? personsResponseList;

  void getPersonsFromServer(context) {
    emit(PersonGettingLoadingState());
    DioHelper.getData2(path: ApiDataAndEndPoints.getPersonsUrl).then((value) {
      List<dynamic> myList = value.data;

      personsResponseList =
          myList.map((e) => PersonResponse.fromJson(e)).toList();

      showMessage2(context, "Getting Successfully...  from Server");
      emit(PersonGettingSuccessState(personsResponseList!));
    }).catchError((error) {
      print('error $error');
      emit(PersonGettingErrorState(error.toString()));
    });
  }

  late Database _database;

  Database get database => _database;

  void createDatabase() {
    print('createDatabase person');
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database _database, int version) {
        _database
            .execute(
                'CREATE TABLE notes (id INTEGER PRIMARY KEY,text TEXT,userId TEXT,placeDateTime TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print(error.toString());
        });

        _database
            .execute(
                'CREATE TABLE person (id INTEGER PRIMARY KEY,userName TEXT,'
                'email TEXT,password TEXT,intrestId TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print(error.toString());
        });
      },
      onOpen: (Database _database) {
        this._database = _database;
        // getDataFromDatabase(_database);
        print('opened');
      },
    ).then((value) {
      print('crrrrrrrrrr person $value');
      _database = value;
      emit(AppCreateDatabaseState2());
    });
  }

  void getPersonFromDatabase(Database _database,context) {
    var myList = [];
    emit(PersonGettingLoadingState());
    _database.rawQuery('SELECT * FROM person').then((value) {
      value.forEach((element) {
        myList.add(element);
      });
      personsResponseList =
          myList.map((e) => PersonResponse.fromJson(e)).toList();

      showMessage2(context, "Getting Successfully...  from Local Database");
      emit(PersonGettingSuccessState(personsResponseList!));
    });
  }

  Future<void> showMessage2(context, message) async {
    return Flushbar(
      margin: const EdgeInsets.all(8),
      borderRadius: BorderRadius.circular(8),
      title: "Hey Ninja",
      message: message,
      duration: const Duration(seconds: 3),
    ).show(context);
  }

}