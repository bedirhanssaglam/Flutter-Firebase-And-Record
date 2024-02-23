import 'package:flutter/material.dart' show State;
import 'package:flutter_record_and_firebase_service/feature/home/service/home_service.dart';
import 'package:flutter_record_and_firebase_service/feature/home/view/home_view.dart';
import 'package:flutter_record_and_firebase_service/feature/home/view_model/home_view_model.dart';
import 'package:flutter_record_and_firebase_service/product/base/firebase/firebase_service.dart';

/// Defining a mixin for the home view
mixin HomeViewMixin on State<HomeView> {
  late final HomeViewModel homeViewModel;

  @override
  void initState() {
    super.initState();
    // Initializing HomeViewModel with HomeService and FirebaseService
    homeViewModel = HomeViewModel(HomeService(FirebaseService()));

    // Fetching home list asynchronously after the view is initialized
    Future.microtask(() => homeViewModel.fetchHomeList());
  }
}
