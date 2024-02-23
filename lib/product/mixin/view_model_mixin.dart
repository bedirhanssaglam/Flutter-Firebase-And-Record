import 'dart:developer' show log;

import 'package:flutter/foundation.dart' show ValueSetter;
import 'package:flutter_record_and_firebase_service/product/base/model/failure.dart';

/// Defining a mixin for view models
base mixin ViewModelMixin {
  /// Method to process response from Firebase call
  void processResponse<T>(
    (T?, Failure?) response, {
    required ValueSetter<T> whenSuccess,
    ValueSetter<Failure>? whenError,
  }) {
    if (response.$1 != null) {
      // Calling success callback if response contains data
      whenSuccess.call(response.$1 as T);
    } else if (response.$2 != null) {
      // Calling error callback if response contains error
      if (whenError != null) whenError.call(Failure(response.$2!.errorMessage));
    }
  }

  /// Method to create model from response
  T? tryCreateModel<T>(
    (T?, Failure?) response, {
    ValueSetter<T>? whenSuccess,
    ValueSetter<Failure>? whenError,
  }) {
    T? model;
    if (response.$1 != null) {
      // Creating model if response contains data
      model = response.$1 as T;
      if (whenSuccess != null) whenSuccess.call(model as T);
    } else if (response.$2 != null) {
      // Logging error message if response contains error
      log(response.$2!.errorMessage!);
      if (whenError != null) whenError.call(Failure(response.$2!.errorMessage));
    }
    return model;
  }
}
