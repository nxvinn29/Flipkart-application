import 'dart:async';
import 'package:bazaar/core/models/user_model.dart';

abstract class IAuthRepository {
  Stream<UserModel?> authStateChanges();
  Future<UserModel?> signInWithGoogle();
  Future<UserModel?> signInWithEmailAndPassword(String email, String password);
  Future<UserModel?> signUpWithEmailAndPassword(String email, String password);
  Future<void> sendPasswordResetEmail(String email);
  Future<void> signOut();
  UserModel? get currentUser;
}

class MockAuthRepository implements IAuthRepository {
  UserModel? _currentUser;
  final _controller = StreamController<UserModel?>.broadcast();

  MockAuthRepository() {
    _controller.add(null);
  }

  @override
  Stream<UserModel?> authStateChanges() => _controller.stream;

  @override
  UserModel? get currentUser => _currentUser;

  @override
  Future<UserModel?> signInWithGoogle() async {
    await Future.delayed(const Duration(seconds: 1));
    _currentUser = UserModel(
      id: 'mock_user_1',
      email: 'user@example.com',
      displayName: 'John Doe',
      photoUrl: null,
      createdAt: DateTime.now(),
    );
    _controller.add(_currentUser);
    return _currentUser;
  }

  @override
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    if (email == 'test@example.com' && password == 'password') {
      _currentUser = UserModel(
        id: 'mock_user_2',
        email: email,
        displayName: 'Test User',
        photoUrl: null,
        createdAt: DateTime.now(),
      );
      _controller.add(_currentUser);
      return _currentUser;
    } else {
      throw Exception('Invalid email or password');
    }
  }

  @override
  Future<void> signOut() async {
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    _controller.add(null);
  }

  @override
  Future<UserModel?> signUpWithEmailAndPassword(String email, String password) {
    // TODO: implement signUpWithEmailAndPassword
    throw UnimplementedError();
  }

  @override
  Future<void> sendPasswordResetEmail(String email) {
    // TODO: implement sendPasswordResetEmail
    throw UnimplementedError();
  }

  void dispose() {
    _controller.close();
  }
}
