import 'package:cloud_firestore/cloud_firestore.dart' as firestore;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/core/models/wishlist_item.dart';
import 'package:firebase_auth/firebase_auth.dart'; // To get current user ID

class WishlistRepository {
  final firestore.FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  WishlistRepository(this._firestore, this._auth);

  String? get _currentUserId => _auth.currentUser?.uid;

  // Get a stream of wishlist items for the current user
  Stream<List<WishlistItem>> getWishlistStream() {
    final userId = _currentUserId;
    if (userId == null) {
      return Stream.value([]); // Return an empty stream if no user is logged in
    }
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => WishlistItem.fromJson(doc.data()))
            .toList());
  }

  // Add an item to the wishlist
  Future<void> addWishlistItem(WishlistItem item) async {
    final userId = _currentUserId;
    if (userId == null) {
      throw Exception('User not logged in.');
    }
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .doc(item.id) // Use item.id as document ID
        .set(item.toJson());
  }

  // Remove an item from the wishlist
  Future<void> removeWishlistItem(String itemId) async {
    final userId = _currentUserId;
    if (userId == null) {
      throw Exception('User not logged in.');
    }
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .doc(itemId)
        .delete();
  }
}

final wishlistRepositoryProvider = Provider<WishlistRepository>((ref) {
  return WishlistRepository(firestore.FirebaseFirestore.instance, FirebaseAuth.instance);
});
