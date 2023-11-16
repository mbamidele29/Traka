import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:traka/core/config/config.dart';
import 'package:traka/core/data/keys.dart';
import 'package:traka/core/data/local_storage.dart';
import 'package:traka/core/models/user.dart';
import 'package:traka/core/config/startup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:traka/core/route/keys.dart';
import 'package:traka/core/route/navigation_service.dart';
import 'package:traka/features/auth/services/service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService service;
  AuthCubit(this.service) : super(AuthInitial());

  authWithGoogle() async {
    try {
      emit(AuthLoading());
      User? user = await service.authWithGoogle();
      if (user == null) {
        emit(const AuthError('unable to authenticate user'));
      } else {
        UserModel userModel = UserModel(
            email: user.email!,
            image: user.photoURL,
            firstName: user.displayName ?? '');

        _saveUser(userModel);
        emit(AuthSuccess());
      }
    } catch (ex) {
      emit(AuthError(ex.toString()));
    }
  }

  authWithGithub() async {
    try {
      String url =
          '${AppConfig.githubAuthorizedUrl}?client_id=${AppConfig.githubClientId}&redirect_uri=${AppConfig.githubRedirectUrl}&scope=user,gist,user:email&allow_signup=true';
      var response = await locator<NavigationService>().toWithPameter(
          routeName: RouteKeys.webview,
          data: {'url': url, 'redirectUrl': AppConfig.githubRedirectUrl});
      if (response is String) {
        emit(AuthError(response));
      } else {
        String code = (response['redirectUrl'] as String)
            .replaceFirst("${AppConfig.githubRedirectUrl}?code=", "")
            .trim();

        Response res = await service.githubAuth(
            code: code,
            clientId: AppConfig.githubClientId,
            clientSecret: AppConfig.githubClientSecret);

        if (res.statusCode == 200) {
        } else {
          emit(const AuthError('unable to authenticate user'));
        }
      }
      // if (user == null) {
      emit(const AuthError('unable to authenticate user'));
      // } else {
      //   UserModel userModel = UserModel(
      //       email: user.email!,
      //       image: user.photoURL,
      //       firstName: user.displayName ?? '');

      //   _saveUser(userModel);
      //   emit(AuthSuccess());
      // }
    } catch (ex) {
      emit(AuthError(ex.toString()));
    }
  }

  void checkUserLogin() async {
    try {
      emit(AuthLoading());
      String? data = await locator<LocalStorage>()
          .readSecureString(LocalStorageKey.userModel);
      if (data == null || FirebaseAuth.instance.currentUser != null) {
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
}
