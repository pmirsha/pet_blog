import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<User?> get authStateChanges => _auth.authStateChanges();
  User? get currentUser => _auth.currentUser;

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final cred = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      await cred.user!.updateDisplayName(name.trim());
      await _db.collection('users').doc(cred.user!.uid).set({
        'uid': cred.user!.uid,
        'name': name.trim(),
        'email': email.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });
      return null; // null means success
    } on FirebaseAuthException catch (e) {
      return _message(e.code);
    } catch (_) {
      return 'Something went wrong. Please try again.';
    }
  }

  Future<String?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return _message(e.code);
    } catch (_) {
      return 'Something went wrong. Please try again.';
    }
  }

  Future<void> signOut() => _auth.signOut();

  String _message(String code) {
    switch (code) {
      case 'email-already-in-use':
        return 'This email is already registered.';
      case 'invalid-email':
        return 'Please enter a valid email.';
      case 'weak-password':
        return 'Password must be at least 6 characters.';
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Incorrect email or password.';
      case 'network-request-failed':
        return 'No internet connection.';
      default:
        return 'Authentication failed. Please try again.';
    }
  }
}
