import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'my_information.freezed.dart';
part 'my_information.g.dart';

@freezed
class MyInformation with _$MyInformation {
  const factory MyInformation({
    required String name,
    required String uid,
    required int consecutive,
  }) = _MyInformation;

  factory MyInformation.fromJson(Map<String, dynamic> json) =>
      _$MyInformationFromJson(json);
}
