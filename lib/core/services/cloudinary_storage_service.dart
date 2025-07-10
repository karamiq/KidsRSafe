import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';

class CloudinaryUploadService {
  final String cloudName = 'dzadvjpcd';
  final String uploadPreset = 'kidsrsafe_unsigned'; // Unsigned preset name

  final Dio _dio = Dio();
  Future<String?> uploadFile(File file) async {
    final String url = 'https://api.cloudinary.com/v1_1/$cloudName/auto/upload';
    // Validate file
    if (!await file.exists()) {
      return null;
    }
    final fileName = file.path.split('/').last;
    final fileSize = await file.length();

    if (fileSize > 100 * 1024 * 1024) {
      return null;
    }

    return await _attemptUpload(file, fileName, url, uploadPreset);
  }

  Future<String?> _attemptUpload(
    File file,
    String fileName,
    String url,
    String uploadPreset,
  ) async {
    try {
      final multipartFile = await MultipartFile.fromFile(
        file.path,
        filename: fileName,
        contentType: _getContentType(fileName),
      );

      final formData = FormData.fromMap({
        'file': multipartFile,
        'upload_preset': uploadPreset,
        'resource_type': 'auto',
      });
      final response = await _dio.post(
        url,
        data: formData,
        options: Options(
          validateStatus: (status) => status != null && status < 500,
          sendTimeout: const Duration(seconds: 60),
          receiveTimeout: const Duration(seconds: 60),
        ),
      );

      if (response.statusCode == 200) {
        return response.data['secure_url'];
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  MediaType? _getContentType(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return MediaType('image', 'jpeg');
      case 'png':
        return MediaType('image', 'png');
      case 'gif':
        return MediaType('image', 'gif');
      case 'webp':
        return MediaType('image', 'webp');
      case 'mp4':
        return MediaType('video', 'mp4');
      case 'mov':
        return MediaType('video', 'quicktime');
      case 'avi':
        return MediaType('video', 'x-msvideo');
      default:
        return null; // Let Cloudinary auto-detect
    }
  }
}
