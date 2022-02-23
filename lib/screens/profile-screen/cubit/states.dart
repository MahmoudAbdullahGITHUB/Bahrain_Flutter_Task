
import 'package:bahrain_flutter_task/model/user/response.dart';

abstract class AddingPersonStates {}

class AddingPersonInitialState extends AddingPersonStates {}

class AddingPersonLoadingState extends AddingPersonStates {}

class AddingPersonSuccessState extends AddingPersonStates {
  // final List<AddingResponse> AddingsResponseList;
  //
  // AddingPersonSuccessState(this.AddingsResponseList);

}

class AddingPersonErrorState extends AddingPersonStates {

  final String error;

  AddingPersonErrorState(this.error);
}
