import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/core/models/user_model.dart';
import 'package:bazaar/features/auth/data/auth_repository.dart';
import 'package:bazaar/features/auth/data/firebase_auth_repository.dart'; // Import the new Firebase repository

final authRepositoryProvider = Provider<IAuthRepository>((ref) => FirebaseAuthRepository()); // Use FirebaseAuthRepository

final authProvider = StreamProvider<UserModel?>((ref) {
  final repository = ref.watch(authRepositoryProvider);
  return repository.authStateChanges();
});

final currentUserProvider = Provider<UserModel?>((ref) {
  final authAsync = ref.watch(authProvider);
  return authAsync.value;
});

final currentUserIdProvider = Provider<String?>((ref) {
  final user = ref.watch(currentUserProvider);
  return user?.id;
});
