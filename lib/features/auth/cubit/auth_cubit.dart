import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:traka/features/auth/services/service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService service;
  AuthCubit(this.service) : super(AuthInitial());

  authWithGoogle() async {
    // try {
    //   emit(AuthLoading());
    //   User? user = await service.authWithGoogle();
    //   if (user == null) {
    //     emit(const AuthError('unable to authenticate user'));
    //   } else {
    //     print(user);
    //   }
    // } catch (ex) {
    //   emit(AuthError(ex.toString()));
    // }
  }
}
