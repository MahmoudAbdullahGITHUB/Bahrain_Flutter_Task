import 'package:bahrain_flutter_task/model/notes/response.dart';
import 'package:bahrain_flutter_task/model/user/response.dart';

abstract class NotesGettingStates {}

class NoteGettingInitialState extends NotesGettingStates {}

class NoteGettingLoadingState extends NotesGettingStates {}

class NoteGettingSuccessState extends NotesGettingStates {
  final List<NoteResponse> notesResponseList;

  NoteGettingSuccessState(this.notesResponseList);
}

class NoteGettingErrorState extends NotesGettingStates {
  final String error;

  NoteGettingErrorState(this.error);
}

class NoteSearchingFillingState extends NotesGettingStates {
  final List<NoteResponse> notesResponseList;

  NoteSearchingFillingState(this.notesResponseList);
}

class NoteSearchingEmptyState extends NotesGettingStates {
  final List<NoteResponse> notesResponseList;

  NoteSearchingEmptyState(this.notesResponseList);
}

class AppCreateDatabaseLoadingState extends NotesGettingStates {}
class AppGetDatabaseState extends NotesGettingStates {}
class AppCreateDatabaseState extends NotesGettingStates {}

class ChangedToggleTest extends NotesGettingStates {}
class LoadingAgain extends NotesGettingStates {}

