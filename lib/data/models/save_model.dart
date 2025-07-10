import 'package:freezed_annotation/freezed_annotation.dart';

part 'save_model.freezed.dart';
part 'save_model.g.dart';

@freezed
abstract class SaveModel with _$SaveModel {
  const factory SaveModel({
    required String userUid,
    required String postUid,
    required DateTime createdAt,
  }) = _SaveModel;

  factory SaveModel.fromJson(Map<String, dynamic> json) => _$SaveModelFromJson(json);
}
