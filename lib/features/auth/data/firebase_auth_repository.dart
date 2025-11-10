import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:bazaar/core/models/user_model.dart';
import 'package:bazaar/features/auth/data/auth_repository.dart';
import 'dart:async';

class FirebaseAuthRepository implements IAuthRepository {
  final fb_auth.FirebaseAuth _firebaseAuth;
  final StreamController<UserModel?> _authStateController = StreamController<UserModel?>.broadcast();

  FirebaseAuthRepository({fb_auth.FirebaseAuth? firebaseAuth})
      : _firebaseAuth = firebaseAuth ?? fb_auth.FirebaseAuth.instance {
    _firebaseAuth.authStateChanges().listen((fb_auth.User? firebaseUser) {
      _authStateController.add(_mapFirebaseUserToUserModel(firebaseUser));
    });
  }

  UserModel? _mapFirebaseUserToUserModel(fb_auth.User? firebaseUser) {
    return firebaseUser == null
        ? null
        : UserModel(
            id: firebaseUser.uid,
            email: firebaseUser.email ?? '',
            displayName: firebaseUser.displayName ?? '',
            photoUrl: firebaseUser.photoURL,
            createdAt: firebaseUser.metadata.creationTime ?? DateTime.now(),
          );
  }

  @override
  Stream<UserModel?> authStateChanges() => _authStateController.stream;

  @override
  UserModel? get currentUser => _mapFirebaseUserToUserModel(_firebaseAuth.currentUser);

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      final fb_auth.GoogleAuthProvider googleProvider = fb_auth.GoogleAuthProvider();
      final fb_auth.UserCredential userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
      return _mapFirebaseUserToUserModel(userCredential.user);
    } catch (_) {
      // print('Error signing in with Google: $e');
      rethrow;
    }
  }

  @override
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      final fb_auth.UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapFirebaseUserToUserModel(userCredential.user);
    } catch (_) {
      // print('Error signing in with email and password: $e');
      rethrow;
    }
  }

  @override
  Future<UserModel?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      final fb_auth.UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return _mapFirebaseUserToUserModel(userCredential.user);
    } catch (_) {
      // print('Error signing up with email and password: $e');
      rethrow;
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (_) {
      // print('Error sending password reset email: $e');
      rethrow;
    }
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  void dispose() {
    _authStateController.close();
  }
}
