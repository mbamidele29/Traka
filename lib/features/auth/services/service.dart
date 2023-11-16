import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:traka/core/config/config.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<User?> authWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn();

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
            await _auth.signInWithCredential(credential);

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

  Future<Response> githubAuth({
    required String code,
    required String clientId,
    required String clientSecret,
  }) async {
    return await post(
      Uri.parse(AppConfig.githubAuthorizedUrl),
      headers: {"Accept": "application/json"},
      body: {
        "code": code,
        "client_id": clientId,
        "client_secret": clientSecret,
      },
    );
  }

  signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      rethrow;
    }
  }
}
