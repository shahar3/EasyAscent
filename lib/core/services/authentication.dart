import 'dart:async';

import 'package:easy_ascent/core/enums/enums.dart';
import 'package:easy_ascent/core/models/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

//Todo: Split auth into firebaseAuth, GoogleAuth and FacebookAuth
abstract class BaseAuth {
  Future signIn(String email, String password);

  Future<String> signUp(String email, String password);

  Future<User> getCurrentUser();

  Future<void> sendEmailVerification();

  Future<void> signOut();

  Future<bool> isEmailVerified();

  Future<void> sendPasswordResetMail(String email);
}

class Auth implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  AuthStatus _status = AuthStatus.Uninitialized;
  User _user;
  Function _notifyListeners;

  User get user => _user;
  AuthStatus get status => _status;
  set notifyListeners(Function notifyListeners) {
    _notifyListeners = notifyListeners;
  }

  Auth() {
    _firebaseAuth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Future<User> getCurrentUser() async {
    FirebaseUser firebaseUser = await _firebaseAuth.currentUser();
    if (firebaseUser != null) {
      _user = User(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
      );
      _status = AuthStatus.Authenticated;
      return _user;
    } else {
      _status = AuthStatus.Unauthenticated;
      return null;
    }
  }

  Future signIn(String email, String password) async {
    try {
      FirebaseUser firebaseUser = (await _firebaseAuth
              .signInWithEmailAndPassword(email: email, password: password))
          .user;

      //Convert FirebaseUser into user
      _user = User(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
      );
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<String> signUp(String email, String password) async {
    FirebaseUser user = (await _firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    return user.uid;
  }

  Future<void> signOut() async {
    return _firebaseAuth.signOut();
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser user = await _firebaseAuth.currentUser();
    return user.isEmailVerified;
  }

  @override
  Future<void> sendPasswordResetMail(String email) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return null;
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    if (firebaseUser == null) {
      _status = AuthStatus.Unauthenticated;
      _user = null;
    } else {
      _status = AuthStatus.Authenticated;
      _user = User(
        uid: firebaseUser.uid,
        email: firebaseUser.email,
      );
    }
    if (_notifyListeners != null) {
      _notifyListeners();
    }
  }
}
