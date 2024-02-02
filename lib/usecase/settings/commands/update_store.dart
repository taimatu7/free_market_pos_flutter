import '../../../domain/store/store.dart';
import '../../../domain/store/store_repository.dart';

class UpdateStore {
  final StoreRepository _storeRepository;

  UpdateStore(this._storeRepository);

  Future<Store> execute(Store store) async {
    return await _storeRepository.update(store);
  }
}
