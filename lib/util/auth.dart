// flutter
import 'package:botob/repogitory/setting_repogitory.dart';
import 'package:flutter/foundation.dart';

// package
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// repogitory
import 'package:botob/repogitory/firestore_user_repogitory.dart';

abstract class AuthBase {
  User? get currentUser;

  Future<User?> createUserWithEmailAndPassword(
      String email, String password, String userName);

  Future<User?> signInWithEmailAndPassword(String email, String password);

  Future<User?> signInWithGoogle();

  Future<User?> signInAnonymously();

  Future<void> signOut();
}

class Auth implements AuthBase {
  final _firebaseAuth = FirebaseAuth.instance;

  // @override
  // Stream<User?> authStateChanges() => _firebaseAuth.authStateChanges();

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User?> createUserWithEmailAndPassword(
      /*
    メールアドレスとパスワードでユーザーを作成
    */
      String email,
      String password,
      String userName) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      final String uid = currentUser!.uid;
      FirestoreUserRepository firestoreUserRepository =
          FirestoreUserRepository();
      SettingRepository settingRepository = SettingRepository();
      await firestoreUserRepository.createFirestoreUser(
        email: email,
        userName: userName,
        userImageUrl: "",
        uid: uid,
        authProvider: currentUser!.providerData[0].providerId,
      );
      await settingRepository.createSetting(uid: uid);
      _firebaseAuth.setLanguageCode('ja');
      await userCredential.user!.sendEmailVerification();
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      } else {
        debugPrint(e.code);
      }
      return null;
    }
  }

  @override
  Future<User?> signInWithEmailAndPassword(
      /*
    メールアドレスとパスワードでサインイン
    */
      String email,
      String password) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      } else {
        debugPrint(e.code);
      }
      return null;
    }
  }

  @override
  Future<User?> signInWithGoogle() async {
    /*
    Googleアカウントでサインイン
    */
    if (kIsWeb) {
      return await _signInWithGoogleForWeb();
    } else {
      return await _signInWithGoogleForMobile();
    }
  }

  Future<User?> _signInWithGoogleForMobile() async {
    /*
    Googleアカウントでサインイン
    android, ios用のコード
    */
    debugPrint('signInWithGoogleForMobile');
    final googleSignIn = GoogleSignIn();
    debugPrint('signInWithGoogleForMobile2');
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth
            .signInWithCredential(GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        ));
        return userCredential.user;
      } else {
        throw FirebaseAuthException(
          code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
          message: 'Missing Google ID Token',
        );
      }
    } else {
      throw FirebaseAuthException(
        code: 'ERROR_ABORTED_BY_USER',
        message: 'Sign in aborted by user',
      );
    }
  }

  Future<User?> _signInWithGoogleForWeb() async {
    /*
    Googleアカウントでサインイン
    web用のコード
    */
    GoogleAuthProvider authProvider = GoogleAuthProvider();
    try {
      // 認証に成功したら、ユーザー情報を返す
      final UserCredential userCredential =
          await _firebaseAuth.signInWithPopup(authProvider);
      User user = userCredential.user!;

      FirestoreUserRepository firestoreUserRepository =
          FirestoreUserRepository();
      SettingRepository settingRepository = SettingRepository();
      bool uidExists = await firestoreUserRepository.uidExistsInFireStore(
        uid: user.uid,
      );

      if (!uidExists) {
        // firestoreにユーザー情報が存在しない場合
        // firestoreにユーザー情報を作成する
        await firestoreUserRepository.createFirestoreUser(
          email: user.email ?? "",
          userName: user.displayName ?? "",
          uid: user.uid,
          userImageUrl: user.photoURL ?? "",
          authProvider: user.providerData[0].providerId,
        );
        await settingRepository.createSetting(uid: user.uid);
      }
      return userCredential.user;
    } catch (e) {
      print(e);
      // handle the error here
      return null;
    }
  }

  @override
  Future<User?> signInAnonymously() async {
    /*
    匿名でサインイン
    */
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user;
  }

  @override
  Future<void> signOut() async {
    // web用の場合は以下は不要
    // final googleSignIn = GoogleSignIn();
    // await googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}

  // // IOS, Androidアプリ用のコード
  // // この時点で、Google認証の画面が表示される
  // final GoogleSignIn googleSignIn = GoogleSignIn();
  // final GoogleSignInAccount? googleSignInAccount =
  //     await googleSignIn.signIn();
  // if (googleSignInAccount != null) {
  //   // google認証の情報を取得
  //   final GoogleSignInAuthentication googleAuth =
  //       await googleSignInAccount.authentication;
  //   final AuthCredential credential = GoogleAuthProvider.credential(
  //     accessToken: googleAuth.accessToken,
  //     idToken: googleAuth.idToken,
  //   );
  //   try {
  //     // 認証に成功したら、ユーザー情報を返す
  //     final UserCredential userCredential =
  //         await _firebaseAuth.signInWithCredential(credential);
  //     return userCredential.user;
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'account-exists-with-different-credential') {
  //       // handle the error here
  //     } else if (e.code == 'invalid-credential') {
  //       // handle the error here
  //     }
  //   } catch (e) {
  //     // handle the error here
  //   }
  // }
