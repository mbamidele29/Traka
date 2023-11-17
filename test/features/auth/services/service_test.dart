import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mocktail/mocktail.dart';
import 'package:traka/features/auth/services/service.dart';

class MockUser extends Mock implements User {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

class MockGoogleSignIn extends Mock implements GoogleSignIn {}

class MockGoogleSignInAccount extends Mock implements GoogleSignInAccount {}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {}

class MockUserCredential extends Mock implements UserCredential {}

class MockAuthCredential extends Mock implements AuthCredential {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  setUpAll(() {
    registerFallbackValue(MockAuthCredential());
  });

  group('AuthService Tests', () {
    setUp(() {});

    test('Google Authentication Test', () async {
      var auth = MockFirebaseAuth();
      final authService = AuthService(auth);
      // Mock Google Sign-In
      final mockGoogleSignInAccount = MockGoogleSignInAccount();
      final mockGoogleSignInAuthentication = MockGoogleSignInAuthentication();
      when(() => MockGoogleSignIn().signIn())
          .thenAnswer((_) async => mockGoogleSignInAccount);
      when(() => mockGoogleSignInAccount.authentication)
          .thenAnswer((_) async => mockGoogleSignInAuthentication);

      // Mock FirebaseAuth sign-in
      when(() => auth.signInWithCredential(captureAny()))
          .thenAnswer((_) async => MockUserCredential());

      // final user = await authService.authWithGoogle();

      // // Verify that the user is not null after Google authentication
      // expect(user, isNotNull);

      // // Sign out the user
      // await authService.signOut();

      // // Verify that the user is signed out
      // verify(() => mockFirebaseAuth.signOut()).called(1);
    });
  });
}
