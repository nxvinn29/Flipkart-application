import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/core/models/order.dart';
import 'package:bazaar/core/repositories/order_repository.dart';

final orderProvider = StreamProvider.autoDispose<List<Order>>((ref) {
  final orderRepository = ref.watch(orderRepositoryProvider);
  return orderRepository.getOrdersStream();
});
