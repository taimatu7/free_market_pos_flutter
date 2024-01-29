import 'store.dart';

abstract interface class StoreRepository {
  Future<Store> create(Store store);
}
