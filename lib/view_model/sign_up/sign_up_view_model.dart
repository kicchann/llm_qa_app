// package
import 'package:hooks_riverpod/hooks_riverpod.dart';

// view_model
import 'package:botob/view_model/sign_up/sign_up_state.dart';

final signUpViewModelProvider =
    AutoDisposeNotifierProvider<SignUpViewModel, SignUpState>(
  SignUpViewModel.new,
);

/// 会員登録の各種画面で使用する ViewModel
class SignUpViewModel extends AutoDisposeNotifier<SignUpState> {
  @override
  SignUpState build() {
    return const SignUpState();
  }

  /// メールアドレスの変更
  void updateEmail(String email) {
    state = state.copyWith(
      email: email,
    );
  }

  /// パスワードの変更
  void updatePassword(String password) {
    state = state.copyWith(
      password: password,
    );
  }

  /// ユーザー名の変更
  void updateUserName(String userName) {
    state = state.copyWith(userName: userName);
  }

  /// パスワードの表示・非表示
  void toggleObscure() {
    state = state.copyWith(
      isObscure: !state.isObscure,
    );
  }
}
