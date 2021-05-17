import 'package:flutter/foundation.dart';
import 'package:innosoft/data_providers/models/ResponseModel.dart';
import 'package:innosoft/data_providers/models/User.dart';
import 'package:innosoft/resources/ApiParseKeys.dart';
import 'package:innosoft/resources/NetworkUtilities.dart';
import 'package:innosoft/resources/URL.dart';

class UsersProvider {
  static Future<ResponseViewModel<List<User>>> getUsers(int pageNumber,
      {int pageSize}) async {
    String url = URL.getRetrieveUsers(pageSize, pageNumber);

    ResponseViewModel userInfoResponse =
        await NetworkUtilities.handleGetRequest(
            methodURL: url,
            requestHeaders: {},
            parserFunction: (Map<String, dynamic> serverRawResponse) {
              try {
                return User.fromListJson(
                    serverRawResponse[ApiParseKeys.USER_API_DATA_ROOT]);
              } catch (userParseException) {
                debugPrint(userParseException);
                return [];
              }
            });

    return ResponseViewModel<List<User>>(
      isSuccess: userInfoResponse.isSuccess,
      serverData: userInfoResponse.responseData,
      serverError: userInfoResponse.serverError,
    );
  }
}
