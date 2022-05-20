import 'package:firebase_auth/firebase_auth.dart';
import 'package:multimeister/models/base_user.dart';
import 'package:multimeister/services/database.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseService databaseService = DatabaseService();
  BaseUser? _userFromFirebaseUser(User? user) {
    if (user != null) {
      return BaseUser(
        uid: user.uid,
        email: user.email,
      );
    }

    return null;
  }

  Stream<BaseUser?> get user {
    return _auth
        .authStateChanges()
        .map((User? user) => _userFromFirebaseUser(user));
  }

  // sign in with email&password
  Future<String> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      BaseUser? baseUser = _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'Adresa de e-mail gresita';
      } else if (e.code == 'wrong-password') {
        return 'Parola gresita';
      }
    }
    return "success";
  }

  // register in with email&password
  Future<String> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // user will be saved in provider
      User? user = result.user;
      BaseUser? baseUser = _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Parola nu este destul de puternica';
      } else if (e.code == 'email-already-in-use') {
        return 'Exista deja un cont pentru acest e-mail';
      }
    }
    return "success";
  }

  // sign-out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
