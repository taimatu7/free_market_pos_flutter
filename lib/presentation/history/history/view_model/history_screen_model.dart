import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/purchase_history/purchase_history.dart';

part '../../../../generated/presentation/history/history/view_model/history_screen_model.freezed.dart';

@freezed
class HistoryScreenModel with _$HistoryScreenModel {
  const factory HistoryScreenModel({
    @Default([]) List<PurchaseHistory> purchaseProducts,
  }) = _HistoryScreenModel;
}
