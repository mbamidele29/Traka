import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
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

  checkUserLogin() async {
    try {
      emit(AuthLoading());
      String? data = await locator<LocalStorage>()
          .readSecureString(LocalStorageKey.userModel);
      if (data == null) return false;
      UserModel userModel = UserModel.fromJson(jsonDecode(data));
      _saveUser(userModel);
      emit(AuthSuccess());
    } catch (ex) {
      // emit(AuthError(ex.toString()));
    }
  }

  void _saveUser(UserModel userModel) {
    locator.registerSingleton<UserModel>(userModel);
    locator<LocalStorage>()
        .writeSecureObject(key: LocalStorageKey.userModel, value: userModel);
  }
}
