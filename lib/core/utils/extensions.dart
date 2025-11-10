import 'package:intl/intl.dart';

extension PriceFormatting on double {
  String toPrice() {
    final formatter = NumberFormat.currency(symbol: '₹', decimalDigits: 0);
    return formatter.format(this);
  }
}

extension DiscountCalculation on double {
  double applyDiscount(int discountPercent) {
    return this * (1 - discountPercent / 100);
  }
}
