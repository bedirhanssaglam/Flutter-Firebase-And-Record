import 'package:flutter/material.dart';
import 'package:flutter_record_and_firebase_service/feature/home/model/home_model.dart';
import 'package:flutter_record_and_firebase_service/feature/home/view/mixin/home_view_mixin.dart';
import 'package:flutter_record_and_firebase_service/product/constants/product_constants.dart';
import 'package:flutter_record_and_firebase_service/product/enums/product_enums.dart';

part '../widget/home_list.dart';

final class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with HomeViewMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder<LoadingState>(
        valueListenable: homeViewModel.loadingStateNotifier,
        builder: (context, loadingState, child) => loadingState == LoadingState.busy
            ? const Center(child: CircularProgressIndicator.adaptive())
            : ValueListenableBuilder<List<HomeModel>?>(
                valueListenable: homeViewModel.homeListNotifier,
                builder: (context, homeList, child) => homeViewModel.failureNotifier.value != null
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(Paddings.low.padding),
                          child: Text(homeViewModel.failureNotifier.value!.errorMessage!),
                        ),
                      )
                    : _HomeList(homeList: homeList ?? []),
              ),
      ),
    );
  }
}
