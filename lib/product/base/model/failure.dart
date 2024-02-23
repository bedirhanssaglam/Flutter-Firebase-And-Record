import 'package:flutter/foundation.dart' show immutable;

@immutable
final class Failure {
  const Failure(this.errorMessage);

  final String? errorMessage;
}
