import '../../../domain/store/store.dart';
import '../../../domain/store/store_repository.dart';

class RegisterStore {
  final StoreRepository _storeRepository;

  RegisterStore(this._storeRepository);

  Future<Store> execute(Store store) async {
    final result = await _storeRepository.create(store);
    return result;
  }
}
