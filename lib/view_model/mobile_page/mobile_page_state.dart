// package
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'mobile_page_state.freezed.dart';

@freezed
abstract class MobilePageState with _$MobilePageState {
  const factory MobilePageState({
    @Default(0) int index,
    required PageController controller,
  }) = _MobilePageState;
}
