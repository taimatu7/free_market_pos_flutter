import '../../../domain/purchase_history/purchase_history.dart';
import '../../../domain/purchase_history/purchase_history_repository.dart';

class GetPurchaseHistories {
  final PurchaseHistoryRepository _purchaseHistoryRepository;

  GetPurchaseHistories(this._purchaseHistoryRepository);

  Future<List<PurchaseHistory>> execute() {
    return _purchaseHistoryRepository.getAll();
  }
}
