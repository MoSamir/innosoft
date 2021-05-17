import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:innosoft/blocs/events/UserEvents.dart';
import 'package:innosoft/blocs/states/UserStates.dart';
import 'package:innosoft/data_providers/models/ResponseModel.dart';
import 'package:innosoft/data_providers/models/User.dart';
import 'package:innosoft/resources/Constants.dart';
import 'package:innosoft/resources/NetworkUtilities.dart';

import '../../Repository.dart';

class UserBloc extends Bloc<UserEvents, UserStates> {
  UserBloc(UserStates initialState) : super(initialState ?? UserDataLoading());

  List<User> usersList = [];
  int pageNumber = 1;

  static const int PAGE_SIZE = 6;

  final int pageSize = 6;
  bool dataEnded = false;

  @override
  Stream<UserStates> mapEventToState(UserEvents event) async* {
    bool isConnected = await NetworkUtilities.isConnected();
    if (isConnected == false) {
      yield UserDataLoadingFailed(
          error: Constants.connectionTimeoutException, failedEvent: event);
      return;
    }
    if (event is LoadUsers) {
      yield* _handleUserLoading(event);
      return;
    }
  }

  Stream<UserStates> _handleUserLoading(LoadUsers event) async* {
    if (dataEnded == false) {
      ResponseViewModel<List<User>> usersListResponse =
          await Repository.getUsers(pageNumber, pageSize: PAGE_SIZE);
      if (usersListResponse.isSuccess) {
        pageNumber++;
        if (usersListResponse.responseData.length < pageSize) dataEnded = true;
        usersList.addAll(usersListResponse.responseData);
        yield UserDataLoadingSuccess();
        return;
      } else {
        yield UserDataLoadingFailed(
            error: usersListResponse.serverError, failedEvent: event);
        return;
      }
    } else {
      yield UserDataLoadingSuccess();
      return;
    }
  }
}
