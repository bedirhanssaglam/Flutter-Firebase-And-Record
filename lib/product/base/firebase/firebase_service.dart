import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_record_and_firebase_service/product/base/model/failure.dart';
import 'package:flutter_record_and_firebase_service/product/constants/product_constants.dart';
import 'package:flutter_record_and_firebase_service/product/enums/product_enums.dart';

/// Defining a generic function type for JSON deserialization
typedef FromJson<T> = T Function(Map<String, dynamic> json);

/// Declaring a class for Firebase service operations
@immutable
final class FirebaseService {
  Future<(R?, Failure?)> fetchDocs<T, R>({
    required FromJson<T> fromJson,
    required CollectionEnums path,
  }) async {
    try {
      // Fetching documents from Firestore collection
      final querySnapshot = await path.collection.get();
      // Returning fetched documents if any, else returning an empty list
      return querySnapshot.docs.isNotEmpty
          ? (
              List<T>.from(querySnapshot.docs.map((snapshot) => fromJson(snapshot.data()),).toList()) as R,
              null,
            )
          : (List<T>.from([]) as R, null);
    } on FirebaseException catch (e) {
      // Handling Firebase exceptions
      return (null, Failure(e.message ?? ProductConstants.errorMessage));
    } catch (e) {
      // Handling other exceptions
      return (null, Failure(e.toString()));
    }
  }
}
