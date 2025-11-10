import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bazaar/core/models/address.dart';
import 'package:bazaar/core/repositories/address_repository.dart';

final addressProvider = StreamProvider.autoDispose<List<Address>>((ref) {
  final addressRepository = ref.watch(addressRepositoryProvider);
  return addressRepository.getAddressesStream();
});
