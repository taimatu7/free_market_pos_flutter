import '../../../domain/store/store.dart';
import '../../../domain/store/store_repository.dart';

class GetStore {
  final StoreRepository _storeRepository;

  GetStore(this._storeRepository);

  Future<Store> execute() async {
    return await _storeRepository.get();
  }
}
