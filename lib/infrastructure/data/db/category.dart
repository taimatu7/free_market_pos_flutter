import 'package:realm/realm.dart';

import '../../../domain/category/category.dart' as domain;

part '../../../generated/infrastructure/data/db/category.g.dart';

@RealmModel()
class _Category {
  @PrimaryKey()
  late String id;
  late String name;
}

extension CategoryExtension on _Category {
  domain.Category toDomainModel() {
    return domain.Category(id: id, name: name);
  }
}
