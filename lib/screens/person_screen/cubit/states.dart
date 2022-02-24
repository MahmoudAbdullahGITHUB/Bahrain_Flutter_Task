import 'package:bahrain_flutter_task/model/user/response.dart';

abstract class AddingPersonStates {}

class AddingPersonInitialState extends AddingPersonStates {}

class AddingPersonLoadingState extends AddingPersonStates {}

class AddingPersonSuccessState extends AddingPersonStates {}

class AddingPersonErrorState extends AddingPersonStates {
  final String error;

  AddingPersonErrorState(this.error);
}

class AppCreateDatabaseState extends AddingPersonStates {}

class AppInsertDatabaseState extends AddingPersonStates {}

class ChangedToggleTest3 extends AddingPersonStates {}
