import 'dart:io';

import 'package:innosoft/data_providers/models/ErrorViewModel.dart';

class Constants {
  static final ErrorViewModel connectionTimeoutException = ErrorViewModel(
    errorMessage: '',
    errorCode: HttpStatus.requestTimeout,
  );
}
