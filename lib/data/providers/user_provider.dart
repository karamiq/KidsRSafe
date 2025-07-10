import 'package:app/data/models/user_model.dart';
import 'package:app/core/services/shared_preference/preferences.dart';
import 'package:app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'object_preference_provider.dart';

part 'user_provider.g.dart';

@riverpod
class User extends _$User with NullableObjectPreferenceProvider {
  @override
  @protected
  String get key => Preferences.authentication;

  @override
  UserModel? build() => firstBuild();

  @override
  UserModel? fromJson(Map<String, dynamic>? map) => map == null ? null : UserModel.fromJson(map);

  @override
  Map<String, dynamic>? toJson(UserModel? value) => value?.toJson();

  Future<void> logout() async {
    await clear();
    // ignore: avoid_manual_providers_as_generated_provider_dependency
    ref.read(routerProvider).go(RoutesDocument.login);
  }

  bool isSignedIn() => build()?.uid != null;
}
