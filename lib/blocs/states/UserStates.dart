import 'package:innosoft/blocs/events/UserEvents.dart';
import 'package:innosoft/data_providers/models/ErrorViewModel.dart';

abstract class UserStates {}

class UserDataLoading extends UserStates {}

class UserDataLoadingFailed extends UserStates {
  final ErrorViewModel error;

  final UserEvents failedEvent;

  UserDataLoadingFailed({this.error, this.failedEvent});
}

class UserDataLoadingSuccess extends UserStates {}
