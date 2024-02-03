import 'package:realm/realm.dart';

import '../../../domain/product/product.dart' as domain;

part '../../../generated/infrastructure/data/db/product.g.dart';

@RealmModel()
class _Product {
  @PrimaryKey()
  late String id;
  late String categoryId;
  late String name;
}

extension ProductExtension on _Product {
  domain.Product toDomainModel() {
    return domain.Product(id: id, categoryId: categoryId, name: name);
  }
}
