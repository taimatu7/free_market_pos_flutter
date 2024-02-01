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
    try {
      final storeModel = realm.Store(store.name);
      _realm.write(() {
        _realm.add(storeModel);
      });
      return store;
    } catch (e, stackTrace) {
      Logger().e('店舗作成エラー:$e', stackTrace: stackTrace);
      throw CreateStoreException('');
    }
  }
}
