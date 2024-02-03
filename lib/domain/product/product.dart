import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ulid/ulid.dart';

import '../../infrastructure/data/db/product.dart' as realm;

part '../../generated/domain/product/product.freezed.dart';

@freezed
class Product with _$Product {
  const factory Product({
    required String id,
    required String categoryId,
    required String name,
  }) = _Product;
  factory Product.generate(String name, String categoryId) => Product(id: Ulid().toString(), categoryId: categoryId, name: name);
}

extension ProductExtension on Product {
  realm.Product toRealmModel() {
    return realm.Product(id, categoryId, name);
  }
}
