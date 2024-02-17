import 'package:logger/logger.dart';
import 'package:realm/realm.dart';

import '../../../domain/product/exceptions/create_product_exception.dart';
import '../../../domain/purchase_history/purchase_history.dart';
import '../../../domain/purchase_history/purchase_history_repository.dart';

class PurchaseHistoryRepositoryImpl implements PurchaseHistoryRepository {
  final Realm _realm;

  PurchaseHistoryRepositoryImpl(this._realm);

  // TODO: 一旦usecaseは戻り値を返しているが、戻り値がvoidでいいところはリファクタリングで修正する
  @override
  Future<List<PurchaseHistory>> create(List<PurchaseHistory> histories) async {
    try {
      final historyModels = histories.map((e) => e.toRealmModel()).toList();
      _realm.write(() {
        _realm.addAll(historyModels);
      });
      return histories;
    } catch (e, stackTrace) {
      Logger().e('履歴作成エラー:$e', stackTrace: stackTrace);
      throw CreateProductException('');
    }
  }

  @override
  Future<PurchaseHistory> delete(PurchaseHistory product) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<List<PurchaseHistory>> getAll() {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<PurchaseHistory> update(PurchaseHistory product) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
