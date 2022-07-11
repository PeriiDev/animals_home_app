import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInService {
  static GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  static Future<GoogleSignInAccount?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        print(account);
        final googleKey = await account.authentication;
        print(googleKey.idToken);

        //LLAMAR UN SERVICIO A NUESTRO BACKEND CON EL ID TOKEN
        
      }
      return account;
    } catch (error) {
      print(error);
      return null;
    }
  }

  static Future signOut() async {
    await _googleSignIn.signOut();
  }
}
