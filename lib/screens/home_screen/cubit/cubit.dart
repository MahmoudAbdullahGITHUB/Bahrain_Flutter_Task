import 'dart:async';
import 'dart:convert';

import 'package:another_flushbar/flushbar.dart';
import 'package:bahrain_flutter_task/model/notes/response.dart';
import 'package:bahrain_flutter_task/model/user/response.dart';
import 'package:bahrain_flutter_task/network/remote/dio_helper.dart';
import 'package:bahrain_flutter_task/screens/home_screen/cubit/states.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';

class NotesGettingCubit extends Cubit<NotesGettingStates> {
  NotesGettingCubit() : super(NoteGettingInitialState());

  static NotesGettingCubit get(context) => BlocProvider.of(context);

  List<NoteResponse>? notesResponseList;
  List<NoteResponse>? notesResponseTempList;
  List<NoteResponse>? searchedNotes = [];

  void getNotesFromServer(context) {
    emit(NoteGettingLoadingState());
    DioHelper.getData2(path: ApiDataAndEndPoints.getNotesUrl).then((value) {
      List<dynamic> myList = value.data;

      notesResponseList = myList.map((e) => NoteResponse.fromJson(e)).toList();
      notesResponseTempList = notesResponseList;
      showMessage2(context, "Getting Successfully...  from Server");
      emit(NoteGettingSuccessState(notesResponseList!));
    }).catchError((error) {
      print('error $error');
      emit(NoteGettingErrorState(error.toString()));
    });
  }

  void searchingNotes(String text) {
    text = text.toLowerCase();
    searchedNotes = notesResponseList!.where((note) {
      var noteTitle = note.text!.toLowerCase();
      return noteTitle.contains(text);
    }).toList();
    if (text.isNotEmpty) {
      notesResponseList = searchedNotes;
      emit(NoteSearchingFillingState(notesResponseList!));
    } else {
      notesResponseList = notesResponseTempList;
      emit(NoteSearchingEmptyState(notesResponseList!));
    }
  }

  late Database _database;

  Database get database => _database;

  void createDatabase() {
    print('createDatabase');
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
                'CREATE TABLE person (id INTEGER PRIMARY KEY,username TEXT,'
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
      emit(AppCreateDatabaseState());
    });
  }

  void getDataFromDatabase(Database _database, context) {
    var myList = [];
    notesResponseList = [];
    notesResponseTempList = [];
    emit(AppCreateDatabaseLoadingState());
    notesResponseList = [];
    _database.rawQuery('SELECT * FROM notes').then((value) {
      value.forEach((element) {
        myList.add(element);
      });
      notesResponseList = myList.map((e) => NoteResponse.fromJson(e)).toList();
      notesResponseTempList = notesResponseList;

      showMessage2(context, "Getting Successfully...  from Local Database");
      emit(NoteGettingSuccessState(notesResponseList!));
      // emit(AppGetDatabaseState());
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
