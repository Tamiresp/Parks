import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();
  final fb = FacebookLogin();

  GoogleSignInAccount? _user;
  GoogleSignInAccount get user => _user!;

  Future googleLogin() async {
    try {
      final googleUser = await googleSignIn.signIn();
      if (googleUser == null) return;
      _user = googleUser;

      final googleAuth = await googleUser.authentication;

      final credencial = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      await FirebaseAuth.instance.signInWithCredential(credencial);
    } catch (e) {
      print(e.toString());
    }

    notifyListeners();
  }

  Future fbSignIn() async {
    try {
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      switch (res.status) {
        case FacebookLoginStatus.success:
          final FacebookAccessToken? accessToken = res.accessToken;
          final AuthCredential authCredential =
              FacebookAuthProvider.credential(accessToken!.token);
          await FirebaseAuth.instance.signInWithCredential(authCredential);
          break;
        case FacebookLoginStatus.cancel:
          break;
        case FacebookLoginStatus.error:
          print('Error while log in: ${res.error}');
          break;
      }
    } catch (e) {
      print(e.toString());
    }
    notifyListeners();
  }

  Future logout() async {
    bool isFbConnect = await fb.isLoggedIn;
    if (isFbConnect) {
      await fb.logOut();
    } else {
      await googleSignIn.disconnect();
    }

    FirebaseAuth.instance.signOut();
  }
}
