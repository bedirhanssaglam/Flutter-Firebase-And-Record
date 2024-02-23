import 'package:flutter_record_and_firebase_service/feature/home/model/home_model.dart';
import 'package:flutter_record_and_firebase_service/product/base/firebase/firebase_service.dart';
import 'package:flutter_record_and_firebase_service/product/base/model/failure.dart';
import 'package:flutter_record_and_firebase_service/product/enums/product_enums.dart';

final class HomeService {
  HomeService(FirebaseService firebaseService) : _firebaseService = firebaseService;
  final FirebaseService _firebaseService;

  Future<(List<HomeModel>?, Failure?)> fetchHomeList() async {
    return _firebaseService.fetchDocs<HomeModel, List<HomeModel>>(
      fromJson: HomeModel.fromJson,
      path: CollectionEnums.list,
    );
  }
}
