import 'purchase_history.dart';

abstract interface class PurchaseHistoryRepository {
  Future<List<PurchaseHistory>> create(List<PurchaseHistory> history);
  Future<List<PurchaseHistory>> getAll();
  Future<PurchaseHistory> update(PurchaseHistory product);
  Future<PurchaseHistory> delete(PurchaseHistory product);
}
