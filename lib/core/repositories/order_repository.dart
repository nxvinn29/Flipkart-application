import 'package:cloud_firestore/cloud_firestore.dart' as firestore hide Order;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/core/models/order.dart' as bazaar_order;
import 'package:firebase_auth/firebase_auth.dart'; // To get current user ID

class OrderRepository {
  final firestore.FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OrderRepository(this._firestore, this._auth);

  String? get _currentUserId => _auth.currentUser?.uid;

  // Get a stream of orders for the current user
  Stream<List<bazaar_order.Order>> getOrdersStream() {
    final userId = _currentUserId;
    if (userId == null) {
      return Stream.value([]); // Return an empty stream if no user is logged in
    }
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .orderBy('orderDate', descending: true) // Order by date, newest first
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => bazaar_order.Order.fromJson(doc.data()))
            .toList());
  }

  // Add an order (typically after checkout)
  Future<void> addOrder(bazaar_order.Order order) async {
    final userId = _currentUserId;
    if (userId == null) {
      throw Exception('User not logged in.');
    }
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(order.id) // Use order.id as document ID
        .set(order.toJson());
  }
}

final orderRepositoryProvider = Provider<OrderRepository>((ref) {
  return OrderRepository(firestore.FirebaseFirestore.instance, FirebaseAuth.instance);
});
