// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_set.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ProblemSet _$$_ProblemSetFromJson(Map<String, dynamic> json) =>
    _$_ProblemSet(
      question: json['question'] as String,
      answer: json['answer'] as String,
      commentary: json['commentary'] as String,
      answerForSelect: json['answerForSelect'] as String,
      similarAnswer: (json['similarAnswer'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_ProblemSetToJson(_$_ProblemSet instance) =>
    <String, dynamic>{
      'question': instance.question,
      'answer': instance.answer,
      'commentary': instance.commentary,
      'answerForSelect': instance.answerForSelect,
      'similarAnswer': instance.similarAnswer,
    };
