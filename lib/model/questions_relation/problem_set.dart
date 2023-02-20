import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'problem_set.freezed.dart';
part 'problem_set.g.dart';

@freezed
class ProblemSet with _$ProblemSet {
  const factory ProblemSet({
    required String question,
    required String answer,
    required String commentary,
    required String answerForSelect,
    required List<String> similarAnswer,
  }) = _ProblemSet;

  factory ProblemSet.fromJson(Map<String, dynamic> json) =>
      _$ProblemSetFromJson(json);
}