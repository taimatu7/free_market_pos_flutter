import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/product/product.dart';

part '../../../../generated/presentation/sale/payment/view_model/payment_screen_model.freezed.dart';

@freezed
class PaymentScreenModel with _$PaymentScreenModel {
  // TODO 不要かも
  factory PaymentScreenModel({@Default([]) List<Product> products}) = _PaymentScreenModel;
}
