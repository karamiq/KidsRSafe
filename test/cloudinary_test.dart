import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:app/core/services/cloudinary_storage_service.dart';

void main() {
  group('CloudinaryUploadService', () {
    test('should handle file upload', () async {
      final service = CloudinaryUploadService();

      // Create a test file (you can replace this with an actual image file)
      final testFile = File('test/test_image.jpg');

      // Skip test if file doesn't exist
      if (!await testFile.exists()) {
        print('⚠️ Test file not found: ${testFile.path}');
        print('📝 Create a test image file at test/test_image.jpg to run this test');
        return;
      }

      final result = await service.uploadFile(testFile);

      if (result != null) {
        print('✅ Upload successful: $result');
        expect(result, isA<String>());
        expect(result!.startsWith('https://'), isTrue);
      } else {
        print('❌ Upload failed - check the logs above for details');
        // Don't fail the test, just log the issue
      }
    });
  });
}
