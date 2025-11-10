import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_model.freezed.dart';
part 'address_model.g.dart';

@freezed
class Address with _$Address {
  const factory Address({
    required String id,
    required String fullName,
    required String phoneNumber,
    required String streetAddress,
    required String city,
    required String state,
    required String postalCode,
    @Default(false) bool isDefault,
  }) = _Address;

  factory Address.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Address(
      id: doc.id,
      fullName: data['fullName'] as String,
      phoneNumber: data['phoneNumber'] as String,
      streetAddress: data['streetAddress'] as String,
      city: data['city'] as String,
      state: data['state'] as String,
      postalCode: data['postalCode'] as String,
      isDefault: data['isDefault'] as bool? ?? false,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
}

extension AddressX on Address {
  Map<String, dynamic> toFirestore() {
    return {
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'streetAddress': streetAddress,
      'city': city,
      'state': state,
      'postalCode': postalCode,
      'isDefault': isDefault,
    };
  }
}
