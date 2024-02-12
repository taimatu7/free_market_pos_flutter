import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/product/product.dart';
import 'payment_screen_model.dart';

final paymentViewModelProvider = StateNotifierProvider<PaymentScreenViewModel, PaymentScreenModel>((ref) => PaymentScreenViewModel());

class PaymentScreenViewModel extends StateNotifier<PaymentScreenModel> {
  PaymentScreenViewModel() : super(PaymentScreenModel());

  void setProducts(List<Product> products) {
    state = state.copyWith(products: products);
  }
}
