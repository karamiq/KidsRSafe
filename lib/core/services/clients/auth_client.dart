import 'package:app/data/models/user_model.dart';
import 'package:app/core/services/clients/callback.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '_clients.dart';

part "auth_client.g.dart";

@riverpod
AuthClient authClient(Ref ref) => AuthClient(ref.dio);

@RestApi()
abstract class AuthClient {
  factory AuthClient(Dio dio, {String baseUrl}) = _AuthClient;

  @POST('/login')
  FutureApiResponse<UserModel> login(@Body() dynamic data);
}
