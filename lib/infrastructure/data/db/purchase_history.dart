import 'package:realm/realm.dart';

import '../../../domain/purchase_history/purchase_history.dart' as domain;
import '../../../domain/purchase_history_detail/purchase_history_detail.dart' as domain;

part '../../../generated/infrastructure/data/db/purchase_history.g.dart';

@RealmModel()
class _PurchaseHistory {
  late String id;
  late DateTime createdAt;
  late _PurchaseHistoryDetail? details;
}

extension PurchaseHistoryExtension on _PurchaseHistory {
  domain.PurchaseHistory toDomainModel() {
    return domain.PurchaseHistory(id: id, createdAt: createdAt, details: details?.toDomainModel());
  }
}

@RealmModel()
class _PurchaseHistoryDetail {
  late String productId;
  late int quantity;
  late int price;
}

extension _PurchaseHistoryDetailExtension on _PurchaseHistoryDetail {
  domain.PurchaseHistoryDetail toDomainModel() {
    return domain.PurchaseHistoryDetail(productId: productId, quantity: quantity, price: price);
  }
}
