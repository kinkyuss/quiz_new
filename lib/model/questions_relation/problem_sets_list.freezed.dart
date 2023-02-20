// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'problem_sets_list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ProblemSetsList _$ProblemSetsListFromJson(Map<String, dynamic> json) {
  return _ProblemSetsList.fromJson(json);
}

/// @nodoc
mixin _$ProblemSetsList {
  List<String> get question => throw _privateConstructorUsedError;
  List<String> get answer => throw _privateConstructorUsedError;
  List<String> get answerForSelect => throw _privateConstructorUsedError;
  List<List<String>> get similarAnswer => throw _privateConstructorUsedError;
  List<String> get commentary => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ProblemSetsListCopyWith<ProblemSetsList> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProblemSetsListCopyWith<$Res> {
  factory $ProblemSetsListCopyWith(
          ProblemSetsList value, $Res Function(ProblemSetsList) then) =
      _$ProblemSetsListCopyWithImpl<$Res, ProblemSetsList>;
  @useResult
  $Res call(
      {List<String> question,
      List<String> answer,
      List<String> answerForSelect,
      List<List<String>> similarAnswer,
      List<String> commentary});
}

/// @nodoc
class _$ProblemSetsListCopyWithImpl<$Res, $Val extends ProblemSetsList>
    implements $ProblemSetsListCopyWith<$Res> {
  _$ProblemSetsListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? answer = null,
    Object? answerForSelect = null,
    Object? similarAnswer = null,
    Object? commentary = null,
  }) {
    return _then(_value.copyWith(
      question: null == question
          ? _value.question
          : question // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answer: null == answer
          ? _value.answer
          : answer // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answerForSelect: null == answerForSelect
          ? _value.answerForSelect
          : answerForSelect // ignore: cast_nullable_to_non_nullable
              as List<String>,
      similarAnswer: null == similarAnswer
          ? _value.similarAnswer
          : similarAnswer // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      commentary: null == commentary
          ? _value.commentary
          : commentary // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ProblemSetsListCopyWith<$Res>
    implements $ProblemSetsListCopyWith<$Res> {
  factory _$$_ProblemSetsListCopyWith(
          _$_ProblemSetsList value, $Res Function(_$_ProblemSetsList) then) =
      __$$_ProblemSetsListCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<String> question,
      List<String> answer,
      List<String> answerForSelect,
      List<List<String>> similarAnswer,
      List<String> commentary});
}

/// @nodoc
class __$$_ProblemSetsListCopyWithImpl<$Res>
    extends _$ProblemSetsListCopyWithImpl<$Res, _$_ProblemSetsList>
    implements _$$_ProblemSetsListCopyWith<$Res> {
  __$$_ProblemSetsListCopyWithImpl(
      _$_ProblemSetsList _value, $Res Function(_$_ProblemSetsList) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? question = null,
    Object? answer = null,
    Object? answerForSelect = null,
    Object? similarAnswer = null,
    Object? commentary = null,
  }) {
    return _then(_$_ProblemSetsList(
      question: null == question
          ? _value._question
          : question // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answer: null == answer
          ? _value._answer
          : answer // ignore: cast_nullable_to_non_nullable
              as List<String>,
      answerForSelect: null == answerForSelect
          ? _value._answerForSelect
          : answerForSelect // ignore: cast_nullable_to_non_nullable
              as List<String>,
      similarAnswer: null == similarAnswer
          ? _value._similarAnswer
          : similarAnswer // ignore: cast_nullable_to_non_nullable
              as List<List<String>>,
      commentary: null == commentary
          ? _value._commentary
          : commentary // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ProblemSetsList
    with DiagnosticableTreeMixin
    implements _ProblemSetsList {
  const _$_ProblemSetsList(
      {required final List<String> question,
      required final List<String> answer,
      required final List<String> answerForSelect,
      required final List<List<String>> similarAnswer,
      required final List<String> commentary})
      : _question = question,
        _answer = answer,
        _answerForSelect = answerForSelect,
        _similarAnswer = similarAnswer,
        _commentary = commentary;

  factory _$_ProblemSetsList.fromJson(Map<String, dynamic> json) =>
      _$$_ProblemSetsListFromJson(json);

  final List<String> _question;
  @override
  List<String> get question {
    if (_question is EqualUnmodifiableListView) return _question;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_question);
  }

  final List<String> _answer;
  @override
  List<String> get answer {
    if (_answer is EqualUnmodifiableListView) return _answer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answer);
  }

  final List<String> _answerForSelect;
  @override
  List<String> get answerForSelect {
    if (_answerForSelect is EqualUnmodifiableListView) return _answerForSelect;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_answerForSelect);
  }

  final List<List<String>> _similarAnswer;
  @override
  List<List<String>> get similarAnswer {
    if (_similarAnswer is EqualUnmodifiableListView) return _similarAnswer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_similarAnswer);
  }

  final List<String> _commentary;
  @override
  List<String> get commentary {
    if (_commentary is EqualUnmodifiableListView) return _commentary;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_commentary);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ProblemSetsList(question: $question, answer: $answer, answerForSelect: $answerForSelect, similarAnswer: $similarAnswer, commentary: $commentary)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ProblemSetsList'))
      ..add(DiagnosticsProperty('question', question))
      ..add(DiagnosticsProperty('answer', answer))
      ..add(DiagnosticsProperty('answerForSelect', answerForSelect))
      ..add(DiagnosticsProperty('similarAnswer', similarAnswer))
      ..add(DiagnosticsProperty('commentary', commentary));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ProblemSetsList &&
            const DeepCollectionEquality().equals(other._question, _question) &&
            const DeepCollectionEquality().equals(other._answer, _answer) &&
            const DeepCollectionEquality()
                .equals(other._answerForSelect, _answerForSelect) &&
            const DeepCollectionEquality()
                .equals(other._similarAnswer, _similarAnswer) &&
            const DeepCollectionEquality()
                .equals(other._commentary, _commentary));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_question),
      const DeepCollectionEquality().hash(_answer),
      const DeepCollectionEquality().hash(_answerForSelect),
      const DeepCollectionEquality().hash(_similarAnswer),
      const DeepCollectionEquality().hash(_commentary));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ProblemSetsListCopyWith<_$_ProblemSetsList> get copyWith =>
      __$$_ProblemSetsListCopyWithImpl<_$_ProblemSetsList>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ProblemSetsListToJson(
      this,
    );
  }
}

abstract class _ProblemSetsList implements ProblemSetsList {
  const factory _ProblemSetsList(
      {required final List<String> question,
      required final List<String> answer,
      required final List<String> answerForSelect,
      required final List<List<String>> similarAnswer,
      required final List<String> commentary}) = _$_ProblemSetsList;

  factory _ProblemSetsList.fromJson(Map<String, dynamic> json) =
      _$_ProblemSetsList.fromJson;

  @override
  List<String> get question;
  @override
  List<String> get answer;
  @override
  List<String> get answerForSelect;
  @override
  List<List<String>> get similarAnswer;
  @override
  List<String> get commentary;
  @override
  @JsonKey(ignore: true)
  _$$_ProblemSetsListCopyWith<_$_ProblemSetsList> get copyWith =>
      throw _privateConstructorUsedError;
}
