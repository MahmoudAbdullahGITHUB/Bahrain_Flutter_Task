import 'dart:async';
import 'dart:convert';

import 'package:bahrain_flutter_task/model/notes/response.dart';
import 'package:bahrain_flutter_task/model/user/response.dart';
import 'package:bahrain_flutter_task/network/remote/dio_helper.dart';
import 'package:bahrain_flutter_task/screens/home_screen/cubit/states.dart';
import 'package:bahrain_flutter_task/screens/users-screen/cubit/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NotesGettingCubit extends Cubit<NotesGettingStates> {
  NotesGettingCubit() : super(NoteGettingInitialState());

  static NotesGettingCubit get(context) => BlocProvider.of(context);

  List<NoteResponse>? notesResponseList;
  List<NoteResponse>? notesResponseTempList;
  List<NoteResponse>? searchedNotes = [];

  void getNotes({
    String? token,
  }) {
    emit(NoteGettingLoadingState());
    DioHelper.getData2(path: ApiDataAndEndPoints.getNotesUrl).then((value) {
      List<dynamic> myList = value.data;

      notesResponseList =
          myList.map((e) => NoteResponse.fromJson(e)).toList();
      notesResponseTempList = notesResponseList;
      print('${notesResponseList![0].text}');

      emit(NoteGettingSuccessState(notesResponseList!));
    }).catchError((error) {
      print('error $error');
      emit(NoteGettingErrorState(error.toString()));
    });
  }


  void searchingNotes(String text){
    text = text.toLowerCase();
    searchedNotes = notesResponseList!.where((note) {
      var noteTitle = note.text!.toLowerCase();
      return noteTitle.contains(text);
    } ).toList();
    if(text.isNotEmpty){
      print('$text');
      notesResponseList=searchedNotes;
      emit(NoteSearchingFillingState(notesResponseList!));
    }else{
      print('text');
      notesResponseList = notesResponseTempList;
      emit(NoteSearchingEmptyState(notesResponseList!));
    }
  }

}