import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/category/category.dart';
import '../../../../domain/product/product.dart';

part '../../../../generated/presentation/registration/product/view_model/product_screen_model.freezed.dart';

@freezed
class ProductScreenModel with _$ProductScreenModel {
  factory ProductScreenModel({@Default([]) List<Category> categories, @Default([]) List<Product> products}) = _ProductScreenModel;
}
