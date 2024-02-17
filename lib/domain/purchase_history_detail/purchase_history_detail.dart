import 'package:freezed_annotation/freezed_annotation.dart';

import '../../infrastructure/data/db/purchase_history.dart' as realm;

part '../../generated/domain/purchase_history_detail/purchase_history_detail.freezed.dart';

@freezed
class PurchaseHistoryDetail with _$PurchaseHistoryDetail {
  const factory PurchaseHistoryDetail({
    required String productId,
    required int quantity,
    required int price,
  }) = _PurchaseHistoryDetail;
}

extension PurchaseHistoryDetailExtension on PurchaseHistoryDetail {
  realm.PurchaseHistoryDetail toRealmModel() {
    return realm.PurchaseHistoryDetail(
      productId,
      quantity,
      price,
    );
  }
}
