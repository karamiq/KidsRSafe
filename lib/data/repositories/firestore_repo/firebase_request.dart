import 'package:app/core/firebase/errors.dart';
import 'package:app/core/services/clients/_clients.dart';
import '../../../core/utils/snackbar.dart';

part 'firebase_request.g.dart';

@riverpod
class FirebaseRequest<T> extends _$FirebaseRequest {
  @override
  dynamic build() {}

  Future<T> auth<T>(
    Future<T> Function() request,
  ) async {
    try {
      final result = await request();

      return result;
    } catch (e) {
      Utils.showErrorSnackBar(getFirebaseAuthErrorMessage(e.toString(), 'en'));
      rethrow;
    }
  }

  Future<T> run<T>(
    Future<T> Function() request,
  ) async {
    try {
      final result = await request();

      return result;
    } catch (e) {
      Utils.showErrorSnackBar(e.toString());
      rethrow;
    }
  }
}
