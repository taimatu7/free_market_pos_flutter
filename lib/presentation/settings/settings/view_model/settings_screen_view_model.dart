import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../infrastructure/providers/usecase_provider.dart';
import '../../../../usecase/settings/commands/update_store.dart';
import '../../../../usecase/settings/queries/get_store.dart';
import '../../../../usecase/settings/queries/get_version.dart';
import 'settings_screen_model.dart';

final settingsScreenViewModelProvider = StateNotifierProvider<SettingsScreenViewModel, SettingsScreenModel>(
    (ref) => SettingsScreenViewModel(ref.read(getStoreUsecaseProvider), ref.read(getVersionUsecaseProvider), ref.read(updateStoreUsecaseProvider)));

class SettingsScreenViewModel extends StateNotifier<SettingsScreenModel> {
  SettingsScreenViewModel(this._getStore, this._getVersion, this._updateStore) : super(SettingsScreenModel());
  final GetStore _getStore;
  final GetVersion _getVersion;
  final UpdateStore _updateStore;

  Future<void> init() async {
    await getStore();
    await getVersion();
  }

  Future<void> getStore() async {
    try {
      final store = await _getStore.execute();
      state = state.copyWith(store: store);
    } catch (e) {
      Logger().e('店舗情報が取得できませんでした');
    }
  }

  Future<void> getVersion() async {
    final version = await _getVersion.execute();
    state = state.copyWith(version: version);
  }

  Future<void> updateStore(String storeName) async {
    final local = state.store?.copyWith(name: storeName);
    if (local == null) return;

    final store = local.copyWith(name: storeName);
    final updatedStore = await _updateStore.execute(store);
    state = state.copyWith(store: updatedStore);
  }
}
