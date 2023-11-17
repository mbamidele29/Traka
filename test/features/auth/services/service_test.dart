import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in_mocks/google_sign_in_mocks.dart';
import 'package:traka/features/auth/services/service.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('AuthService Tests', () {
    late MockUser mockUser;
    late FirebaseAuth mockFirebaseAuth;
    setUp(() {
      mockUser = MockUser(
        isAnonymous: false,
        uid: 'j0hnd0e',
        displayName: 'John',
        email: 'johndoe@test.com',
      );
      mockFirebaseAuth = MockFirebaseAuth(mockUser: mockUser);
    });

    test('Should auth user with google signin', () async {
      final googleSignIn = MockGoogleSignIn();
      final authService =
          AuthService(auth: mockFirebaseAuth, googleSignIn: googleSignIn);

      final user = await authService.authWithGoogle();
      expect(user, isNotNull);
      expect(user, mockUser);
    });

    test('Should signout user', () async {
      await mockFirebaseAuth.signOut();
      expect(mockFirebaseAuth.currentUser, null);
    });
  });
}
