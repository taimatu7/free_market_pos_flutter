import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/product/product.dart';

part '../../../../generated/presentation/components/cart/view_model/cart_model.freezed.dart';

@freezed
class CartModel with _$CartModel {
  const factory CartModel({required List<Product> products}) = _CartModel;
}
