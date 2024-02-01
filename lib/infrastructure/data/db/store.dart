import 'package:realm/realm.dart';

import '../../../domain/store/store.dart' as domain;

part '../../../generated/infrastructure/data/db/store.g.dart';

@RealmModel()
class _Store {
  late String name;
}

extension StoreExtension on _Store {
  domain.Store toDomainModel() {
    return domain.Store(name: name);
  }
}
