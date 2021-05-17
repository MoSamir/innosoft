import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:innosoft/blocs/bloc/UsersBloc.dart';
import 'package:innosoft/blocs/events/UserEvents.dart';
import 'package:innosoft/blocs/states/UserStates.dart';
import 'package:innosoft/resources/LocalKeys.dart';
import 'package:innosoft/ui/widgets/custom_appbar.dart';
import 'package:innosoft/ui/widgets/user_card.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  UserBloc _usersDataBloc = UserBloc(UserDataLoading());

  ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _usersDataBloc.add(LoadUsers());
    _scrollController.addListener(() {
      _scrollController.offset;
      loadMorePages();
    });
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.position.maxScrollExtent == 0) {
        _usersDataBloc.add(LoadUsers());
      }
    });

    return Scaffold(
      appBar: CustomAppbar(),
      body: BlocConsumer(
        bloc: _usersDataBloc,
        listener: (context, state) {
          if (state is UserDataLoadingFailed) {
            if ((state.error.errorCode == HttpStatus.requestTimeout) == false) {
              Fluttertoast.showToast(
                  msg: state.error.errorMessage,
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        },
        builder: (context, state) {
          if (state is UserDataLoadingFailed) {
            if (state.error.errorCode == HttpStatus.requestTimeout &&
                _usersDataBloc.usersList.isEmpty) {
              return _errorView(state.failedEvent);
            }
          }

          return ModalProgressHUD(
            inAsyncCall: state is UserDataLoading,
            child: ListView.builder(
              shrinkWrap: true,
              physics: AlwaysScrollableScrollPhysics(),
              controller: _scrollController,
              itemBuilder: (context, index) {
                return UserCard(
                  user: _usersDataBloc.usersList[index],
                );
              },
              itemCount: _usersDataBloc.usersList.length,
            ),
          );
        },
      ),
    );
  }

  void loadMorePages() {
    if (_scrollController.offset >=
            (_scrollController.position.maxScrollExtent - 500) &&
        !_scrollController.position.outOfRange &&
        (_usersDataBloc.state is UserDataLoading == false)) {
      _usersDataBloc.add(LoadUsers());
    }
  }

  Widget _errorView(UserEvents failedEvent) {
    return Center(
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text((LocalKeys.CONNECTION_TIMEOUT_MESSAGE).tr()),
          TextButton(
              onPressed: () {
                _usersDataBloc.add(failedEvent);
              },
              child: Text((LocalKeys.RETRY_LABEL).tr()))
        ],
      ),
    );
  }
}
