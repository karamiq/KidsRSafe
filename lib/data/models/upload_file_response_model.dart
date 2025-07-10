import './_models.dart';

part 'upload_file_response_model.freezed.dart';
part 'upload_file_response_model.g.dart';

@freezedResponse
abstract class UploadFileResponseModel with _$UploadFileResponseModel {
  const UploadFileResponseModel._();

  @jsonSerializableResponse
  const factory UploadFileResponseModel({
    required String path,
    String? url,
  }) = _UploadFileResponseModel;

  factory UploadFileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UploadFileResponseModelFromJson(json);
}
