import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ulid/ulid.dart';

import '../../infrastructure/data/db/category.dart' as realm;

part '../../generated/domain/category/category.freezed.dart';

@freezed
class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
  }) = _Category;
  factory Category.generate(String name) => Category(id: Ulid().toString(), name: name);
}

extension CategoryExtension on Category {
  realm.Category toRealmModel() {
    return realm.Category(id, name);
  }
}
