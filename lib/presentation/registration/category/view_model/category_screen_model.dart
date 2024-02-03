import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/category/category.dart';

part '../../../../generated/presentation/registration/category/view_model/category_screen_model.freezed.dart';

@freezed
class CategoryScreenModel with _$CategoryScreenModel {
  factory CategoryScreenModel({@Default([]) List<Category> categories}) = _CategoryScreenModel;
}
