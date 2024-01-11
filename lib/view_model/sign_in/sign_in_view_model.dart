// package
import 'package:hooks_riverpod/hooks_riverpod.dart';

// view_model
import 'package:botob/view_model/sign_in/sign_in_state.dart';

final signInViewModelProvider =
    AutoDisposeNotifierProvider<SignInViewModel, SignInState>(
  SignInViewModel.new,
);

/// 会員登録の各種画面で使用する ViewModel
class SignInViewModel extends AutoDisposeNotifier<SignInState> {
  @override
  SignInState build() {
    return const SignInState();
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

  /// パスワードの表示・非表示
  void toggleObscure() {
    state = state.copyWith(
      isObscure: !state.isObscure,
    );
  }
}
