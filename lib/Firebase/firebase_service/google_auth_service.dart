import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

GoogleSignIn googleSignIn = GoogleSignIn();

String? name;
String? email;
String? imageUrl;

Future signInWithGoogle() async {
  final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount!.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken);
  UserCredential authResult =
      await FirebaseAuth.instance.signInWithCredential(credential);
  User? user = authResult.user;

  name = user!.displayName;
  email = user.email;
  imageUrl = user.photoURL;
}

Future<void> signOutGoogle() async {
  await googleSignIn.signOut();

  print('User Signed Out');
}
