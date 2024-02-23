import 'package:flutter/foundation.dart' show immutable;

@immutable
final class HomeModel {
  const HomeModel({this.name});

  factory HomeModel.fromJson(Map<String, dynamic> json) => HomeModel(name: json['name'] as String?);

  final String? name;
}
