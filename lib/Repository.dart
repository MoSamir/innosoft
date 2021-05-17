import 'dart:async';

import 'package:innosoft/data_providers/models/ResponseModel.dart';

import 'data_providers/apis/users_data_provider.dart';
import 'data_providers/models/User.dart';

class Repository {
  static Future<ResponseViewModel<List<User>>> getUsers(int page,
      {int pageSize = 10}) async {
    return await UsersProvider.getUsers(page, pageSize: pageSize);
  }
}
