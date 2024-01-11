// packages
import 'package:flutter_riverpod/flutter_riverpod.dart';

// constants
import 'package:botob/constant/strings.dart';

// models
import 'package:botob/model/reffered_document/reffered_document.dart';

// view_model
import 'package:botob/view_model/new_content/new_content_state.dart';

final newContentViewModelProvider =
    StateNotifierProvider.autoDispose<NewContentViewModel, NewContentState>(
        (ref) {
  // contentIdにはuuidを事前に割り振っておく
  NewContentState newContentState = NewContentState(
    contentId: returnUuidV4(),
  );
  return NewContentViewModel(newContentState);
});

class NewContentViewModel extends StateNotifier<NewContentState> {
  NewContentViewModel(NewContentState contentState) : super(contentState);

  void updateTitle(String title) {
    state = state.copyWith(
      title: title,
    );
  }

  void updateBody(String body) {
    state = state.copyWith(
      body: body,
    );
  }

  void addRefferedContent(RefferedDocument refferedDocument) {
    state = state.copyWith(
        refferedDocuments: state.refferedDocuments + [refferedDocument]);
  }

  void updateRefferedDocuments(List<RefferedDocument> refferedDocuments) {
    state = state.copyWith(refferedDocuments: refferedDocuments);
  }

  void removeRefferedContent(RefferedDocument refferedDocument) {
    List<RefferedDocument> newRefferedDocuments = [];
    for (RefferedDocument refferedDocument in state.refferedDocuments) {
      if (refferedDocument.storageContentId !=
          refferedDocument.storageContentId) {
        newRefferedDocuments.add(refferedDocument);
      }
    }
    state = state.copyWith(refferedDocuments: newRefferedDocuments);
  }

  void refresh() {
    state = state.copyWith(
      title: '',
      body: '',
      refferedDocuments: [],
      contentId: returnUuidV4(),
    );
  }

  void setContentId(String contentId) {
    state = state.copyWith(
      contentId: contentId,
    );
  }
}
