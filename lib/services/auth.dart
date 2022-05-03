import 'package:firebase_auth/firebase_auth.dart';
import 'package:multimeister/models/base_user.dart';

class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create baseUser based on firebase user
  BaseUser? _userFromFirebaseUser(User? user){
    if (user != null) {
      return BaseUser(uid: user.uid);
    }
    
    return null;
  }

  Stream<BaseUser?> get user {
    return _auth.authStateChanges().map((User? user) => _userFromFirebaseUser(user));
  }

  // sign in with email&password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // register in with email&password
  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;

      return _userFromFirebaseUser(user);
    } catch(e) {
      print(e.toString());
      return null;
    }
  }

  // sign-out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}