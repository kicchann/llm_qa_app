// packages
import 'package:botob/model/user_answer/user_answer.dart';
import 'package:botob/model/user_query/user_query.dart';
import 'package:uuid/uuid.dart';

// version
const String versionText = 'v1';

// preferences
const String isDarkThemeKey = 'isDarkTheme';
const String primaryColorKey = 'primaryColor';

// content
const String titleContent = 'タイトル';
const String createdAtContent = '作成日';
const List<String> attrsContent = [titleContent, createdAtContent];
const List<String> contentTypes = ['txt', 'md', 'json', 'pdf'];

// titles
const String appTitle = 'BOTOB';
const String signupPageTitle = '新規登録';
const String signinPageTitle = 'サインイン';
const String adminPageTitle = '管理者';
const String newContentPageTitle = '新規作成';
const String qaPageTitle = 'Q&A';
const String themeDrawerTitle = 'ダークモード';
const String colorDrawerTitle = 'カラー';
const String settingDrawerTitle = '設定';
const String queryTitle = 'お問い合わせ';
const String userNameDialogTitle = 'ユーザー名を変更';
const String userpointDialogTitle = 'ポイントの購入';
const String colorDialogTitle = 'カラーを選択';
const String signinDialogTitle = '確認メールを送信しました';
const String resetPasswordTitle = 'パスワード変更';

// assets
const String googleLogoAsset = 'assets/google-logo.png';

// links
const String queryLink = 'https://forms.gle/b2DTptnKnuiW4c236';

// button text
const String startButtonText = 'はじめる';
const String okButtonText = 'OK';
const String decideButtonText = '決定';
const String cancelButtonText = 'キャンセル';
const String backButtonText = '戻る';
const String closeButtonText = '閉じる';
const String chargeButtonText = 'チャージ';
const String changePasswordButtonText = 'パスワードを変更';
const String signoutButtonText = 'サインアウト';
const String price100ButtonText = '100ポイント (100円)';
const String price1000ButtonText = '1000ポイント (800円)';
const String resetPasswordButtonText = 'パスワードをリセット';
const String selectFileButtonText = 'ファイルを選択';

// texts
const String appDescriptingText = 'AIで独自の文書のQ&Aを簡単に作成できるアプリ';
const String signinDialogText = 'メール内のリンクをクリックして、アカウントを有効化してください';
const String deleteDialogText = '本当に削除しますか？';
const String signUpText = '新規登録';
const String signinText = 'サインイン';
const String userNameText = 'ユーザー名';
const String mailAddressText = 'メールアドレス';
const String passwordText = 'パスワード';
const String obscureText = 'パスワードを非表示にする';
const String signInGoogleText = 'Googleでサインイン';
const String noAccountText = "アカウントをお持ちでない場合";
const String hasAccountText = "アカウントをお持ちの場合";
const String resetPasswordText = "パスワードを忘れた場合";
const String letsAddContentText = 'コンテンツを登録して\n独自のQ&Aツールを作成しましょう';
const String noContentText = 'コンテンツはありません';
const String errorOccurredText = 'エラーが発生しました';
const String deleteFromHereText = '削除はこちら';
const String remainingPointText = 'ポイント残高：';
const String moveToCheckoutText = '決済画面に移動します';
const String titleContentText = 'タイトル';
const String bodyContentText = '本文';
const String enterQueryText = '質問を入力してください';
const String noAnswerText = '回答はまだありません';
const String referenceText = '参照箇所';
const String selectContentText = 'コンテンツを選択してください';
const String contentNotFoundText = 'コンテンツが見つかりませんでした';
const String letsQueryText = '質問してみましょう';
const String pointsForNewContentText = '新規作成には50ポイント必要です';
const String waitForCreatingAiText = 'AIモデルを生成中です\n完了するまでしばらくお待ちください';

// FieldKey
const String productsFieldKey = 'products';
const String pricesFieldKey = 'prices';
const String customersFieldKey = 'customers';
const String sessionsFieldKey = 'checkout_sessions';

const String usersFieldKey = 'users';
const String contentsFieldKey = 'contents';
const String refferedDocumentsFieldKey = 'refferedDocuments';
const String indexManagerFieldKey = 'indexManagers';
const String settingsFieldKey = 'settings';
const String queryFieldKey = 'queries';
const String answerFieldKey = 'answers';

const String userPrefix = 'user';
const String contentPrefix = 'content';
const String queryPrefix = 'query';
const String answerPrefix = 'answer';

// status messages
const String startCreationStatusMeg = 'AIモデルの作成を開始しました';
const String completedStatusMeg = 'AIモデルの作成が完了しました';

// messages
const String userCreatedMsg = 'ユーザーが作成できました';
const String copiedMsg = 'コピーしました';
const String deletedMsg = '削除しました';
const String prohibitedUploadingLargeFile = '10MB以上のファイルはアップロードできません';
const String lackOfPointMsg = 'ポイントが不足しています';
const String sendResetPasswordMsg = 'パスワード変更用のメールを送信しました';
const String failResetPasswordMsg = 'パスワード変更用のメールの送信に失敗しました';

// tab text
const String useFileTabText = 'ファイルを使う';
const String inputDirectlyText = '直接入力';

// bottom navigation bar
const String homeText = "Home";
const String noteText = "Note";
const String profileText = "Profile";

// format text
const String datetimeFormatText = 'yyyy年MM月dd日 kk:mm:ss';

String returnUuidV4({String? prefix}) {
  const Uuid uuid = Uuid();
  return '${uuid.v4()}_$versionText';
}

String returnQATextForClipboard({
  required UserQuery userQuery,
  required UserAnswer? userAnswer,
}) =>
    userAnswer == null
        ? "## 質問\n\n${userQuery.body}"
        : "## 質問\n\n${userQuery.body}\n\n## 回答\n\n ${userAnswer.body}";
