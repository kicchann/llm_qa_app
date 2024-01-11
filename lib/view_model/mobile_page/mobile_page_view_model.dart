// packages
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// view_model
import 'package:botob/view_model/mobile_page/mobile_page_state.dart';

final mobilePageViewModelProvider =
    StateNotifierProvider.autoDispose<MobilePageViewModel, MobilePageState>(
        (ref) {
  return MobilePageViewModel(MobilePageState(
    index: 0,
    controller: PageController(),
  ));
});

class MobilePageViewModel extends StateNotifier<MobilePageState> {
  MobilePageViewModel(MobilePageState mobilePageState) : super(mobilePageState);

  void updateIndex(int index) {
    state = state.copyWith(index: index);
  }
}
