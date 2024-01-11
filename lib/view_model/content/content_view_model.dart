// packages
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// constant
import 'package:botob/constant/strings.dart';

// model
import 'package:botob/model/content/content.dart';

// view_model
import 'package:botob/view_model/content/content_state.dart';

// repogitory
import 'package:botob/repogitory/firebase_user_repogitory.dart';

final contentViewModelProvider =
    StateNotifierProvider.autoDispose<ContentViewModel, ContentState>((ref) {
  final User? user = ref.watch(firebaseUserStreamProvider).value;
  return ContentViewModel(ContentState(
      user: user,
      currentContentId: '',
      sortBy: createdAtContent,
      isAscending: false));
});

class ContentViewModel extends StateNotifier<ContentState> {
  ContentViewModel(ContentState contentState) : super(contentState);

  void updateContent(Content content) {
    state = state.copyWith(currentContentId: content.contentId);
  }

  void updateSortBy(String value) {
    state = state.copyWith(sortBy: value);
  }

  void toggleIsAscending() {
    state = state.copyWith(isAscending: !state.isAscending);
  }
}
