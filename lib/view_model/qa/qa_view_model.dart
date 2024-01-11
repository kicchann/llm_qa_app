// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

// models
import 'package:botob/model/user_query/user_query.dart';

// view_models
import 'package:botob/view_model/qa/qa_state.dart';

final qaViewModelProvider =
    StateNotifierProvider.autoDispose<QaViewModel, QaState>((ref) {
  return QaViewModel(const QaState());
});

class QaViewModel extends StateNotifier<QaState> {
  QaViewModel(QaState contentState) : super(contentState);

  void updateUserQuery(UserQuery userQuery) {
    state = state.copyWith(activeQuery: userQuery);
  }

  void refresh() {
    state = const QaState();
  }
}
