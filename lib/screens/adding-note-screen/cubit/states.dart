
import 'package:bahrain_flutter_task/model/user/response.dart';

abstract class AddingNoteStates {}

class AddingNoteInitialState extends AddingNoteStates {}

class AddingNoteLoadingState extends AddingNoteStates {}

class AddingNoteSuccessState extends AddingNoteStates {
  // final List<AddingResponse> AddingsResponseList;
  //
  // AddingNoteSuccessState(this.AddingsResponseList);

}

class AddingNoteErrorState extends AddingNoteStates {

  final String error;

  AddingNoteErrorState(this.error);
}
