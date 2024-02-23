import 'package:flutter/material.dart';
import 'package:flutter_record_and_firebase_service/feature/home/model/home_model.dart';
import 'package:flutter_record_and_firebase_service/feature/home/service/home_service.dart';
import 'package:flutter_record_and_firebase_service/product/base/model/failure.dart';
import 'package:flutter_record_and_firebase_service/product/enums/product_enums.dart';
import 'package:flutter_record_and_firebase_service/product/mixin/view_model_mixin.dart';

/// Defining a view model class for the home screen
final class HomeViewModel with ViewModelMixin {
  /// Constructor to initialize with HomeService
  HomeViewModel(this._homeService);
  
  /// Private instance of HomeService
  final HomeService _homeService;

  /// Notifier for the list of home models
  ValueNotifier<List<HomeModel>?> homeListNotifier = ValueNotifier<List<HomeModel>?>(null);
  
  /// Notifier for failures
  ValueNotifier<Failure?> failureNotifier = ValueNotifier<Failure?>(null);
  
  /// Notifier for loading state
  ValueNotifier<LoadingState> loadingStateNotifier = ValueNotifier<LoadingState>(LoadingState.idle);

  /// Method to fetch the home list
  Future<void> fetchHomeList() async {
    // Setting loading state to busy
    loadingStateNotifier.value = LoadingState.busy;

    // Fetching home list and updating notifiers
    homeListNotifier.value = tryCreateModel<List<HomeModel>>(
      await _homeService.fetchHomeList(),
      whenError: (Failure failure) {
        failureNotifier.value = failure;
      },
    );

    // Setting loading state to idle after fetching
    loadingStateNotifier.value = LoadingState.idle;
  }
}
