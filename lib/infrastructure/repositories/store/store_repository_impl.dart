import 'package:logger/logger.dart';
import 'package:realm/realm.dart';

import '../../../domain/store/exceptions/create_store_exception.dart';
import '../../../domain/store/store.dart';
import '../../../domain/store/store_repository.dart';
import '../../data/db/store.dart' as realm;

class StoreRepositoryImpl implements StoreRepository {
  StoreRepositoryImpl(this._realm);

  final Realm _realm;

  @override
  Future<Store> create(Store store) async {
    final storeModel = realm.Store(store.name);
    try {
      _realm.write(() {
        _realm.add(storeModel);
      });
    } catch (e, stackTrace) {
      Logger().e(e.toString(), stackTrace: stackTrace);
      throw CreateStoreException('店舗作成エラー');
    }
    return store;
  }
}
