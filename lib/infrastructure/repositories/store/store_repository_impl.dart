import 'package:logger/logger.dart';
import 'package:realm/realm.dart';

import '../../../domain/store/exceptions/create_store_exception.dart';
import '../../../domain/store/exceptions/get_store_exception.dart';
import '../../../domain/store/exceptions/update_store_exception.dart';
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

  @override
  Future<Store?> get() async {
    try {
      final realm.Store? storeModel;
      storeModel = _realm.all<realm.Store>().firstOrNull;
      return storeModel?.toDomainModel();
    } catch (e, stackTrace) {
      Logger().e('店舗取得エラー:$e.toString()', stackTrace: stackTrace);
      throw GetStoreException('');
    }
  }

  @override
  Future<Store> update(Store store) async {
    try {
      final storeModel = _realm.all<realm.Store>().first;
      _realm.write(() {
        storeModel.name = store.name;
      });
      return storeModel.toDomainModel();
    } catch (e, stackTrace) {
      Logger().e('店舗更新エラー:$e', stackTrace: stackTrace);
      throw UpdateStoreException('');
    }
  }
}
