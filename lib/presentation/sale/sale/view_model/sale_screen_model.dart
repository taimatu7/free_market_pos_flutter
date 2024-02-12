import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/category/category.dart';
import '../../../../domain/product/product.dart';

part '../../../../generated/presentation/sale/sale/view_model/sale_screen_model.freezed.dart';

@freezed
class SaleScreenModel with _$SaleScreenModel {
  factory SaleScreenModel({@Default([]) List<Category> categories, @Default([]) List<Product> products}) = _SaleScreenModel;
}
