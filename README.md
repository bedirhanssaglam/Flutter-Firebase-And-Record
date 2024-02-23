<div align="center">
    <h1>Flutter Records And Simple Firebase Service</h1>
</div>

A simple [Firebase](https://firebase.flutter.dev/docs/overview/) Service project that uses the [Records](https://dart.dev/language/records) feature offered by the [Dart](https://dart.dev/) programming language.

#### Firebase Service

```dart
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
```

#### ViewModelMixin

```dart
import 'dart:developer' show log;

import 'package:flutter/foundation.dart' show ValueSetter;

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
```

#### HomeViewModel

```dart
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
```

#### HomeViewMixin

```dart
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
```