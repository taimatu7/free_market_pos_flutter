import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../infrastructure/providers/usecase_provider.dart';
import '../../../../usecase/settings/queries/get_store.dart';
import '../../../../usecase/settings/queries/get_version.dart';
import 'settings_screen_model.dart';

final settingsScreenViewModelProvider = StateNotifierProvider<SettingsScreenViewModel, SettingsScreenModel>(
    (ref) => SettingsScreenViewModel(ref.read(getStoreUsecaseProvider), ref.read(getVersionUsecaseProvider)));

class SettingsScreenViewModel extends StateNotifier<SettingsScreenModel> {
  SettingsScreenViewModel(this._getStore, this._getVersion) : super(SettingsScreenModel());
  final GetStore _getStore;
  final GetVersion _getVersion;

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
}
