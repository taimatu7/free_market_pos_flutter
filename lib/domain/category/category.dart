import 'package:freezed_annotation/freezed_annotation.dart';

import '../../infrastructure/data/db/category.dart' as realm;

part '../../generated/domain/category/category.freezed.dart';

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
  }) = _Category;
}

extension CategoryExtension on Category {
  realm.Category toRealmModel() {
    return realm.Category(id, name);
  }
}
