import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:bahrain_flutter_task/model/adding_note/request.dart';
import 'package:bahrain_flutter_task/model/user/response.dart';
import 'package:bahrain_flutter_task/network/remote/dio_helper.dart';
import 'package:bahrain_flutter_task/screens/adding-note-screen/cubit/states.dart';
import 'package:bahrain_flutter_task/screens/home_screen/cubit/cubit.dart';
import 'package:bahrain_flutter_task/screens/home_screen/cubit/states.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class AddingNoteCubit extends Cubit<AddingNoteStates> {
  AddingNoteCubit() : super(AddingNoteInitialState());

  static AddingNoteCubit get(context) => BlocProvider.of(context);

  NotesGettingCubit? cubit3;

  void cubitAddNoteOnServer({
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

    dynamic toJsonMap = jsonEncode(addingRequest);

    DioHelper.postData2(
      path: ApiDataAndEndPoints.addNoteUrl,
      data: toJsonMap,
    ).then((value) {
      print(value.data);

      ShowMessage2(context);
      print('you make greatness bro =  ');
      cubit3 = NotesGettingCubit.get(context);
      cubit3!.emit(LoadingAgain());

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

  ///  Local Database

  late Database _database;

  Database get database => _database;

  void createDatabase() {
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
        // getDataFromDatabase(_database);
        print('opened');
      },
    ).then((value) {
      _database = value;
      emit(AppCreateDatabaseState0());
    });
  }

  insertToDatabase({
    required String text,
    required String userId,
    required String placeDateTime,
    required context,
  }) async {
    return await _database.transaction((txn) async {
      txn
          .rawInsert(
              'INSERT INTO notes (text,userId,placeDateTime) VALUES ("$text","$userId","$placeDateTime")')
          .then((value) {
        print('note inserted');
        cubit3 = NotesGettingCubit.get(context);
        cubit3!.emit(LoadingAgain());

        emit(AddingNoteSuccessState());
      }).catchError((err) {
        print(err.toString());
      });
    });
  }
}
