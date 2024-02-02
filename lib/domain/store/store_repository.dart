import 'store.dart';

abstract interface class StoreRepository {
  Future<Store> create(Store store);
  Future<Store?> get(); // 1店舗のみなので、引数は不要
}
