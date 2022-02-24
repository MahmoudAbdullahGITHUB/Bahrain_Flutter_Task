
import 'package:bahrain_flutter_task/model/user/response.dart';

abstract class PersonGettingStates {}

class PersonGettingInitialState extends PersonGettingStates {}

class PersonGettingLoadingState extends PersonGettingStates {}

class PersonGettingSuccessState extends PersonGettingStates {
  final List<PersonResponse> personsResponseList;

  PersonGettingSuccessState(this.personsResponseList);

}

class PersonGettingErrorState extends PersonGettingStates {

  final String error;

  PersonGettingErrorState(this.error);
}


class AppCreateDatabaseLoadingState2 extends PersonGettingStates {}
class AppGetDatabaseState2 extends PersonGettingStates {}
class AppCreateDatabaseState2 extends PersonGettingStates {}

class ChangedToggleTest2 extends PersonGettingStates {}
