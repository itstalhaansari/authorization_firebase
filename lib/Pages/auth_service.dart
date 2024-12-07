import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Signinwithgoogle() async {
    final GoogleSignInAccount? GUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication GAuth = await GUser!.authentication;
    final credential = GoogleAuthProvider.credential(
        accessToken: GAuth.accessToken, idToken: GAuth.idToken);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
