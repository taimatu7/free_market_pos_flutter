import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../infrastructure/providers/usecase_provider.dart';
import '../../../../usecase/history/queries/get_purchase_histories.dart';
import 'history_screen_model.dart';

final paymentViewModelProvider =
    StateNotifierProvider<HistoryScreenViewModel, HistoryScreenModel>((ref) => HistoryScreenViewModel(ref.read(getPurchaseHistoryUsecaseProvider)));

class HistoryScreenViewModel extends StateNotifier<HistoryScreenModel> {
  HistoryScreenViewModel(this._getPurchaseHistory) : super(const HistoryScreenModel());

  final GetPurchaseHistories _getPurchaseHistory;

  Future<bool> getHistories() async {
    try {
      final result = await _getPurchaseHistory.execute();
      state = state.copyWith(purchaseProducts: result);
      return true;
    } catch (e) {
      return false;
    }
  }
}
