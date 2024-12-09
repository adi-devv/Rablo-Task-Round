import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;
  
  User? getCurrentUser(){
    return _auth.currentUser;
  }

  Future<UserCredential> signInWithEmailPassword(String email, password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
  }

  Future<UserCredential> signUpWithEmailPassword(String email, password, phone,name) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      _firestore.collection('Users').doc(userCredential.user!.uid).set(
        {
          'uid': userCredential.user!.uid,
          'email': email,
          'phone': phone,
          'name':name,
        },
      );

      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw (e.code);
    }
  }

  Future<void> signOut() async {
    return await _auth.signOut();
  }
}
