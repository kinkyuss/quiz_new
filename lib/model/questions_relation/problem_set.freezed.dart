// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'problem_set.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProblemSet _$ProblemSetFromJson(Map<String, dynamic> json) {
  return _ProblemSet.fromJson(json);
}

/// @nodoc
mixin _$ProblemSet {
  String get question => throw _privateConstructorUsedError;
  String get answer => throw _privateConstructorUsedError;
  String get commentary => throw _privateConstructorUsedError;
  String get answerForSelect => throw _privateConstructorUsedError;
  List<String> get similarAnswer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProblemSetCopyWith<ProblemSet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProblemSetCopyWith<$Res> {
  factory $ProblemSetCopyWith(
          ProblemSet value, $Res Function(ProblemSet) then) =
      _$ProblemSetCopyWithImpl<$Res, ProblemSet>;
  @useResult
  $Res call(
      {String question,
      String answer,
      String commentary,
      String answerForSelect,
      List<String> similarAnswer});
}

/// @nodoc
class _$ProblemSetCopyWithImpl<$Res, $Val extends ProblemSet>
    implements $ProblemSetCopyWith<$Res> {
  _$ProblemSetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? answer = null,
    Object? commentary = null,
    Object? answerForSelect = null,
    Object? similarAnswer = null,
  }) {
    return _then(_value.copyWith(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      commentary: null == commentary
          ? _value.commentary
          : commentary // ignore: cast_nullable_to_non_nullable
              as String,
      answerForSelect: null == answerForSelect
          ? _value.answerForSelect
          : answerForSelect // ignore: cast_nullable_to_non_nullable
              as String,
      similarAnswer: null == similarAnswer
          ? _value.similarAnswer
          : similarAnswer // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProblemSetCopyWith<$Res>
    implements $ProblemSetCopyWith<$Res> {
  factory _$$_ProblemSetCopyWith(
          _$_ProblemSet value, $Res Function(_$_ProblemSet) then) =
      __$$_ProblemSetCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String question,
      String answer,
      String commentary,
      String answerForSelect,
      List<String> similarAnswer});
}

/// @nodoc
class __$$_ProblemSetCopyWithImpl<$Res>
    extends _$ProblemSetCopyWithImpl<$Res, _$_ProblemSet>
    implements _$$_ProblemSetCopyWith<$Res> {
  __$$_ProblemSetCopyWithImpl(
      _$_ProblemSet _value, $Res Function(_$_ProblemSet) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? answer = null,
    Object? commentary = null,
    Object? answerForSelect = null,
    Object? similarAnswer = null,
  }) {
    return _then(_$_ProblemSet(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as String,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as String,
      commentary: null == commentary
          ? _value.commentary
          : commentary // ignore: cast_nullable_to_non_nullable
              as String,
      answerForSelect: null == answerForSelect
          ? _value.answerForSelect
          : answerForSelect // ignore: cast_nullable_to_non_nullable
              as String,
      similarAnswer: null == similarAnswer
          ? _value._similarAnswer
          : similarAnswer // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProblemSet with DiagnosticableTreeMixin implements _ProblemSet {
  const _$_ProblemSet(
      {required this.question,
      required this.answer,
      required this.commentary,
      required this.answerForSelect,
      required final List<String> similarAnswer})
      : _similarAnswer = similarAnswer;

  factory _$_ProblemSet.fromJson(Map<String, dynamic> json) =>
      _$$_ProblemSetFromJson(json);

  @override
  final String question;
  @override
  final String answer;
  @override
  final String commentary;
  @override
  final String answerForSelect;
  final List<String> _similarAnswer;
  @override
  List<String> get similarAnswer {
    if (_similarAnswer is EqualUnmodifiableListView) return _similarAnswer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_similarAnswer);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProblemSet(question: $question, answer: $answer, commentary: $commentary, answerForSelect: $answerForSelect, similarAnswer: $similarAnswer)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProblemSet'))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('answer', answer))
      ..add(DiagnosticsProperty('commentary', commentary))
      ..add(DiagnosticsProperty('answerForSelect', answerForSelect))
      ..add(DiagnosticsProperty('similarAnswer', similarAnswer));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProblemSet &&
            (identical(other.question, question) ||
                other.question == question) &&
            (identical(other.answer, answer) || other.answer == answer) &&
            (identical(other.commentary, commentary) ||
                other.commentary == commentary) &&
            (identical(other.answerForSelect, answerForSelect) ||
                other.answerForSelect == answerForSelect) &&
            const DeepCollectionEquality()
                .equals(other._similarAnswer, _similarAnswer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, question, answer, commentary,
      answerForSelect, const DeepCollectionEquality().hash(_similarAnswer));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProblemSetCopyWith<_$_ProblemSet> get copyWith =>
      __$$_ProblemSetCopyWithImpl<_$_ProblemSet>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProblemSetToJson(
      this,
    );
  }
}

abstract class _ProblemSet implements ProblemSet {
  const factory _ProblemSet(
      {required final String question,
      required final String answer,
      required final String commentary,
      required final String answerForSelect,
      required final List<String> similarAnswer}) = _$_ProblemSet;

  factory _ProblemSet.fromJson(Map<String, dynamic> json) =
      _$_ProblemSet.fromJson;

  @override
  String get question;
  @override
  String get answer;
  @override
  String get commentary;
  @override
  String get answerForSelect;
  @override
  List<String> get similarAnswer;
  @override
  @JsonKey(ignore: true)
  _$$_ProblemSetCopyWith<_$_ProblemSet> get copyWith =>
      throw _privateConstructorUsedError;
}
