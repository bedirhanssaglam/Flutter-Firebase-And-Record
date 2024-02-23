import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract final class ProductConstants {
  const ProductConstants._();

  static const String appName = 'Firebase';
  static const String emptyMessage = 'No items found.';
  static const String errorMessage = 'Something went wrong!';
}
