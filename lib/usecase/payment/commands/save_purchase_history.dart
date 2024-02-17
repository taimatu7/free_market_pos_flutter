import '../../../domain/purchase_history/purchase_history.dart';
import '../../../domain/purchase_history/purchase_history_repository.dart';

class SavePurchaseHistory {
  final PurchaseHistoryRepository purchaseHistoryRepository;

  SavePurchaseHistory(this.purchaseHistoryRepository);

  // TODO レコード型をクラスにする
  Future<void> execute(List<PurchaseHistory> purchaseHistory) async {
    await purchaseHistoryRepository.create(purchaseHistory);
  }
}
