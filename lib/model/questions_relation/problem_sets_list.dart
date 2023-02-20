import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'problem_sets_list.freezed.dart';
part 'problem_sets_list.g.dart';

@freezed
class ProblemSetsList with _$ProblemSetsList {
  const factory ProblemSetsList({
    required List <String> question,
    required List <String> answer,
    required List <String> answerForSelect,
    required List <List<String>>  similarAnswer,
    required List <String> commentary,
  }) = _ProblemSetsList;

  factory ProblemSetsList.fromJson(Map<String, dynamic> json) =>
      _$ProblemSetsListFromJson(json);
}