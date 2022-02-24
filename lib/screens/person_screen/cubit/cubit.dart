import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:bahrain_flutter_task/model/adding_user/request.dart';
import 'package:bahrain_flutter_task/model/user/response.dart';
import 'package:bahrain_flutter_task/network/remote/dio_helper.dart';
import 'package:bahrain_flutter_task/screens/person_screen/cubit/states.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AddingPersonCubit extends Cubit<AddingPersonStates> {
  AddingPersonCubit() : super(AddingPersonInitialState());

  static AddingPersonCubit get(context) => BlocProvider.of(context);

  void cubitAddPersonToServer({
    @required String? userName,
    @required String? email,
    @required String? password,
    @required String? intrestId,
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

      showMessage2(context, "Added Successfully...  to Server");
      cubit2 = PersonGettingCubit.get(context);
      PersonGettingStates my2 = ChangedToggleTest2();
      cubit2!.emit(my2);

      emit(AddingPersonSuccessState());
    }).catchError((error) {
      print('error $error ');
      emit(AddingPersonErrorState(error.toString()));
    });
  }

  late Database _database;

  Database get database => _database;
  PersonGettingCubit? cubit2;

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (Database _database, int version) {
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
        // getDataFromDatabase(_database);
        print('opened');
      },
    ).then((value) {
      print('crrrrrrrrrr');
      _database = value;
      emit(AppCreateDatabaseState());
    });
  }

  insertToDatabase({
    @required String? userName,
    @required String? email,
    @required String? password,
    @required String? intrestId,
    required BuildContext context,
  }) async {
    return await _database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO person (userName,email,password,intrestId) VALUES ("$userName","$email","$password","$intrestId")')
          .then((value) {
        print('person inserted');
        showMessage2(context, "Added Successfully...  to Local Database");
        cubit2 = PersonGettingCubit.get(context);
        PersonGettingStates my2 = ChangedToggleTest2();
        cubit2!.emit(my2);

        emit(AppInsertDatabaseState());
      }).catchError((err) {
        print(err.toString());
      });
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
