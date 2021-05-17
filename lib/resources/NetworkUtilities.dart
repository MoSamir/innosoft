import 'dart:convert';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:innosoft/data_providers/models/ErrorViewModel.dart';
import 'package:innosoft/data_providers/models/ResponseModel.dart';

import 'Constants.dart';
import 'LocalKeys.dart';

class NetworkUtilities {
  static Future<bool> isConnected() async {
    if (kIsWeb) return true;
    try {
      final result = await InternetAddress.lookup("google.com")
          .timeout(Duration(seconds: 5), onTimeout: () {
        throw SocketException('');
      });
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  static Future<ResponseViewModel<dynamic>> handleGetRequest(
      {String methodURL,
      Map<String, String> requestHeaders,
      Function parserFunction}) async {
    ResponseViewModel getResponse;

    try {
      var serverResponse = await http
          .get(Uri.parse(methodURL), headers: requestHeaders)
          .timeout(Duration(seconds: 20), onTimeout: () {
        throw SocketException;
      });
      if (serverResponse.statusCode == 200) {
        getResponse = ResponseViewModel(
          isSuccess: true,
          serverError: null,
          serverData: parserFunction(json.decode(serverResponse.body)),
        );
      } else {
        getResponse = _handleError(serverResponse);
      }
    } on SocketException {
      getResponse = ResponseViewModel(
        isSuccess: false,
        serverError: Constants.connectionTimeoutException,
        serverData: null,
      );
    } catch (exception) {
      debugPrint("Exception in get => $exception");
      if (exception == SocketException) {
        getResponse = ResponseViewModel(
          isSuccess: false,
          serverError: Constants.connectionTimeoutException,
          serverData: null,
        );
      } else {
        getResponse = ResponseViewModel(
          isSuccess: false,
          serverError: ErrorViewModel(
            errorMessage: '',
            errorCode: HttpStatus.serviceUnavailable,
          ),
          serverData: null,
        );
      }
    }
    networkLogger(
        url: methodURL,
        body: '',
        headers: requestHeaders,
        response: getResponse);
    return getResponse;
  }

  static void networkLogger({url, headers, body, ResponseViewModel response}) {
    debugPrint('---------------------------------------------------');
    debugPrint('AT => ${DateTime.now().toString()}');
    debugPrint('URL => $url');
    debugPrint('headers => $headers');
    debugPrint('Body => $body');
    debugPrint('Response => ${response.toString()}');
    debugPrint('---------------------------------------------------');
  }

  static ResponseViewModel _handleError(http.Response serverResponse) {
    ResponseViewModel responseViewModel;
    if (serverResponse.statusCode == HttpStatus.unprocessableEntity) {
      List<String> errors = List();
      try {
        (json.decode(serverResponse.body)['errors'] as Map<String, dynamic>)
            .forEach((key, value) {
          if (value is List<String>)
            errors.addAll(value);
          else if (value is List<dynamic>) {
            for (int i = 0; i < value.length; i++)
              errors.add(value[i].toString());
          } else if (value is String) errors.add(value);
        });
      } catch (exception) {
        debugPrint("Exception => $exception");
      }
      responseViewModel = ResponseViewModel(
        isSuccess: false,
        serverError: ErrorViewModel(
          errorMessage: errors.length > 0
              ? errors.join(',')
              : (LocalKeys.SERVER_UNREACHABLE).tr(),
          errorCode: serverResponse.statusCode,
        ),
        serverData: null,
      );
    } else if (serverResponse.statusCode == HttpStatus.internalServerError) {
      responseViewModel = ResponseViewModel(
        isSuccess: false,
        serverError: ErrorViewModel(
          errorMessage: (LocalKeys.SERVER_UNREACHABLE).tr(),
          errorCode: serverResponse.statusCode,
        ),
        serverData: null,
      );
    } else {
      String serverError = (LocalKeys.SERVER_UNREACHABLE).tr();
      try {
        serverError = json.decode(serverResponse.body)['error'] ??
            json.decode(serverResponse.body)['message'];
        if (serverError.isEmpty) {
          serverError = tr(LocalKeys.SERVER_UNREACHABLE);
        }
      } catch (exception) {
        serverError = serverResponse.body;
      }
      responseViewModel = ResponseViewModel(
        isSuccess: false,
        serverError: ErrorViewModel(
          errorMessage: serverError,
          errorCode: serverResponse.statusCode,
        ),
        serverData: null,
      );
    }
    return responseViewModel;
  }
}
