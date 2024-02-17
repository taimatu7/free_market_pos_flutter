import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ulid/ulid.dart';

import '../../../../domain/product/product.dart';
import '../../../../domain/purchase_history/purchase_history.dart';
import '../../../../domain/purchase_history_detail/purchase_history_detail.dart';
import '../../../../infrastructure/providers/usecase_provider.dart';
import '../../../../usecase/payment/commands/save_purchase_history.dart';
import 'payment_screen_model.dart';

final paymentViewModelProvider =
    StateNotifierProvider<PaymentScreenViewModel, PaymentScreenModel>((ref) => PaymentScreenViewModel(ref.read(savePurchaseHistoryUsecaseProvider)));

class PaymentScreenViewModel extends StateNotifier<PaymentScreenModel> {
  PaymentScreenViewModel(this._savePurchaseHistory) : super(PaymentScreenModel());

  final SavePurchaseHistory _savePurchaseHistory;

  bool savePurchaseHistory(List<(Product, int)> paymentDetails) {
    try {
      final ulid = Ulid().toString();
      final date = DateTime.now();
      final purchaseHistories = paymentDetails
          .map((e) => PurchaseHistory(
              id: ulid, createdAt: date, details: PurchaseHistoryDetail(productId: e.$1.id, quantity: e.$2, price: e.$1.price * e.$2)))
          .toList();
      _savePurchaseHistory.execute(purchaseHistories);
      return true;
    } catch (e) {
      return false;
    }
  }
}
