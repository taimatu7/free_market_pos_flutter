import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ulid/ulid.dart';

import '../../infrastructure/data/db/purchase_history.dart' as realm;
import '../purchase_history_detail/purchase_history_detail.dart';

part '../../generated/domain/purchase_history/purchase_history.freezed.dart';

@freezed
class PurchaseHistory with _$PurchaseHistory {
  const factory PurchaseHistory({
    required String id,
    required DateTime createdAt,
    required PurchaseHistoryDetail? details,
  }) = _PurchaseHistory;

  factory PurchaseHistory.generate(PurchaseHistoryDetail details) {
    return PurchaseHistory(
      id: Ulid().toString(),
      createdAt: DateTime.now(),
      details: details,
    );
  }
}

extension PurchaseHistoryExtension on PurchaseHistory {
  realm.PurchaseHistory toRealmModel() {
    return realm.PurchaseHistory(id, createdAt, details: details?.toRealmModel());
  }
}
