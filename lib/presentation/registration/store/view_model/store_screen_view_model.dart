import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/store/store.dart';
import '../../../../infrastructure/providers/usecase_provider.dart';
import '../../../../usecase/registration/commands/register_store.dart';
import '../../../../usecase/settings/queries/get_store.dart';
import 'store_screen_model.dart';

final storeScreenViewModelProvider = StateNotifierProvider<StoreScreenViewModel, StoreScreenModel>(
    (ref) => StoreScreenViewModel(ref.read(registerStoreUsecaseProvider), ref.read(getStoreUsecaseProvider)));

class StoreScreenViewModel extends StateNotifier<StoreScreenModel> {
  StoreScreenViewModel(this._registerStore, this._getStore) : super(StoreScreenModel());
  final RegisterStore _registerStore;
  final GetStore _getStore;

  Future<void> registerStore(String storeName) async {
    final store = Store(name: storeName);
    try {
      await _registerStore.execute(store);
    } catch (e) {
      state = state.copyWith(registered: false);
    }
    state = state.copyWith(registered: true);
  }

  Future<void> existStore() async {
    final store = await _getStore.execute();
    if (store != null) {
      state = state.copyWith(registered: true, isFirstRegistered: false);
    }
  }
}
