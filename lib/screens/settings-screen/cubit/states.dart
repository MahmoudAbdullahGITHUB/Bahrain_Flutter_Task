
import 'package:bahrain_flutter_task/model/user/response.dart';

abstract class SettingsStates {}

class SettingsInitialState extends SettingsStates {}
class SettingsChangeToggleState extends SettingsStates {}

class SettingsLoadingState extends SettingsStates {}

class SettingsSuccessState extends SettingsStates {
  final List<PersonResponse> personsResponseList;

  SettingsSuccessState(this.personsResponseList);

}

class SettingsErrorState extends SettingsStates {

  final String error;

  SettingsErrorState(this.error);
}
