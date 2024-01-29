import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/store/store.dart';
import '../../../../infrastructure/providers/usecase_provider.dart';
import '../../../../usecase/registration/commands/register_store.dart';
import 'store_screen_model.dart';

final storeScreenViewModelProvider =
    StateNotifierProvider<StoreScreenViewModel, StoreScreenModel>((ref) => StoreScreenViewModel(ref.read(registerStoreUsecaseProvider)));

class StoreScreenViewModel extends StateNotifier<StoreScreenModel> {
  StoreScreenViewModel(this._registerStore) : super(StoreScreenModel());
  final RegisterStore _registerStore;

  Future<void> registerStore(String storeName) async {
    final store = Store(name: storeName);
    try {
      await _registerStore.execute(store);
    } catch (e) {
      state = state.copyWith(registered: false);
    }
    state = state.copyWith(registered: true);
  }
}
