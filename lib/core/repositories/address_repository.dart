import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/core/models/address.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AddressRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AddressRepository(this._firestore, this._auth);

  String? get _currentUserId => _auth.currentUser?.uid;

  // Get a stream of addresses for the current user
  Stream<List<Address>> getAddressesStream() {
    final userId = _currentUserId;
    if (userId == null) {
      return Stream.value([]);
    }
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Address.fromJson(doc.data()!))
            .toList());
  }

  // Add a new address
  Future<void> addAddress(Address address) async {
    final userId = _currentUserId;
    if (userId == null) {
      throw Exception('User not logged in.');
    }
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .doc(address.id)
        .set(address.toJson());
  }

  // Update an existing address
  Future<void> updateAddress(Address address) async {
    final userId = _currentUserId;
    if (userId == null) {
      throw Exception('User not logged in.');
    }
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .doc(address.id)
        .update(address.toJson());
  }

  // Delete an address
  Future<void> deleteAddress(String addressId) async {
    final userId = _currentUserId;
    if (userId == null) {
      throw Exception('User not logged in.');
    }
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('addresses')
        .doc(addressId)
        .delete();
  }
}

final addressRepositoryProvider = Provider<AddressRepository>((ref) {
  return AddressRepository(FirebaseFirestore.instance, FirebaseAuth.instance);
});
