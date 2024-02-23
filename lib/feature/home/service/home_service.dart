import 'package:flutter_record_and_firebase_service/feature/home/model/home_model.dart';
import 'package:flutter_record_and_firebase_service/product/base/firebase/firebase_service.dart';
import 'package:flutter_record_and_firebase_service/product/base/model/failure.dart';
import 'package:flutter_record_and_firebase_service/product/enums/product_enums.dart';

/// Defining a final class HomeService
final class HomeService {
  /// Constructor for HomeService which takes an instance of FirebaseService
  HomeService(FirebaseService firebaseService) : _firebaseService = firebaseService;

  /// Declaring a private variable _firebaseService of type FirebaseService
  final FirebaseService _firebaseService;

  /// Defining a method fetchHomeList which returns a Future that may resolve to a tuple containing a List of HomeModel and a Failure object
  Future<(List<HomeModel>?, Failure?)> fetchHomeList() async {
    // Calling the fetchDocs method of _firebaseService
    return _firebaseService.fetchDocs<HomeModel, List<HomeModel>>(
      // Providing the fromJson function to convert fetched data to HomeModel instances
      fromJson: HomeModel.fromJson,
      // Providing the path to the collection from which data needs to be fetched
      path: CollectionEnums.list,
    );
  }
}
