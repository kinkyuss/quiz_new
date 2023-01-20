import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'questions_list.freezed.dart';
part 'questions_list.g.dart';

@freezed
class QuestionsList with _$QuestionsList {
  const factory QuestionsList({
    required List <String> test,
    required List <String> answer,
    required List <String> commentary,

  }) = _QuestionsList;

  factory QuestionsList.fromJson(Map<String, dynamic> json) =>
      _$QuestionsListFromJson(json);
}