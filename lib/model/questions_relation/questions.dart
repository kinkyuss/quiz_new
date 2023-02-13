import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'questions.freezed.dart';
part 'questions.g.dart';

@freezed
class Questions with _$Questions {
  const factory Questions({

    required String test,
    required String answer,
    required String commentary,
    required String answerForSelect,
    required List<String> similarAnswer,
  }) = _Questions;

  factory Questions.fromJson(Map<String, dynamic> json) =>
      _$QuestionsFromJson(json);
}
