import 'package:cloud_firestore/cloud_firestore.dart';

enum LoadingState { idle, busy }

enum Paddings {
  low(12),
  medium(16),
  high(32);

  const Paddings(this.padding);
  final double padding;
}

enum CollectionEnums {
  list,
  ;

  CollectionReference<Map<String, dynamic>> get collection => FirebaseFirestore.instance.collection(name);
}
