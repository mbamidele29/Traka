import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  AuthService({required this.auth, required this.googleSignIn});

  Future<User?> authWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        final UserCredential userCredential =
            await auth.signInWithCredential(credential);

        return userCredential.user;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw Exception(
            'The account already exists with a different credential.');
      } else if (e.code == 'invalid-credential') {
        throw Exception(
            'Error occurred while accessing credentials. Try again.');
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  Future<User?> authWithGithub(String token) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithCredential(GithubAuthProvider.credential(token));

      return userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'account-exists-with-different-credential') {
        throw Exception(
            'The account already exists with a different credential.');
      } else if (e.code == 'invalid-credential') {
        throw Exception(
            'Error occurred while accessing credentials. Try again.');
      }
    } catch (e) {
      rethrow;
    }
    return null;
  }

  signOut() async {
    try {
      await auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
