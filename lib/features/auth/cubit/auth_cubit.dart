import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:github_sign_in_plus/github_sign_in_plus.dart';
import 'package:traka/core/config/config.dart';
import 'package:traka/core/data/keys.dart';
import 'package:traka/core/data/local_storage.dart';
import 'package:traka/core/models/user.dart';
import 'package:traka/core/config/startup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:traka/features/auth/services/service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService service;
  AuthCubit(this.service) : super(AuthInitial());

  authWithGoogle() async {
    try {
      emit(AuthLoading());
      User? user = await service.authWithGoogle();
      _processAuth(user);
    } catch (ex) {
      emit(AuthError(ex.toString()));
    }
  }

  authWithGithub(BuildContext context) async {
    try {
      emit(AuthLoading());
      String? token;
      final GitHubSignIn gitHubSignIn = GitHubSignIn(
          clientId: AppConfig.githubClientId,
          clientSecret: AppConfig.githubClientSecret,
          redirectUrl: AppConfig.githubRedirectUrl);
      var result = await gitHubSignIn.signIn(context);
      switch (result.status) {
        case GitHubSignInResultStatus.ok:
          token = result.token;
          break;
        case GitHubSignInResultStatus.cancelled:
        case GitHubSignInResultStatus.failed:
          throw Exception(result.errorMessage);
      }

      if (token != null) {
        User? user = await service.authWithGithub(token);
        _processAuth(user);
      }
    } catch (ex) {
      emit(AuthError(ex.toString()));
    }
  }

  void checkUserLogin() async {
    try {
      emit(AuthLoading());
      String? data = await locator<LocalStorage>()
          .readSecureString(LocalStorageKey.userModel);
      if (data == null || FirebaseAuth.instance.currentUser == null) {
        _clearuser();
        throw Exception('not signed in');
      }
      UserModel userModel = UserModel.fromJson(jsonDecode(data));
      _saveUser(userModel);
      emit(AuthSuccess());
    } catch (ex) {
      emit(AuthError(ex.toString()));
    }
  }

  signout() async {
    _clearuser();
    await service.signOut();
  }

  _clearuser() {
    locator<LocalStorage>().deleteSecure(LocalStorageKey.userModel);
  }

  void _saveUser(UserModel userModel) {
    locator.registerSingleton<UserModel>(userModel);
    locator<LocalStorage>()
        .writeSecureObject(key: LocalStorageKey.userModel, value: userModel);
  }

  void _processAuth(User? user) {
    if (user == null) {
      emit(const AuthError('unable to authenticate user'));
    } else {
      UserModel userModel = UserModel(
          email: user.email!,
          image: user.photoURL,
          firstName: user.displayName?.split(' ').first ?? '');

      _saveUser(userModel);
      emit(AuthSuccess());
    }
  }
}
