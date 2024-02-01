import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';

import '../../../../infrastructure/providers/usecase_provider.dart';
import '../../../../usecase/settings/queries/get_store.dart';
import 'settings_screen_model.dart';

final settingsScreenViewModelProvider =
    StateNotifierProvider<SettingsScreenViewModel, SettingsScreenModel>((ref) => SettingsScreenViewModel(ref.read(getStoreUsecaseProvider)));

class SettingsScreenViewModel extends StateNotifier<SettingsScreenModel> {
  SettingsScreenViewModel(this._getStore) : super(SettingsScreenModel());
  final GetStore _getStore;

  Future<void> getStore() async {
    try {
      final store = await _getStore.execute();
      state = state.copyWith(store: store);
    } catch (e) {
      Logger().e('店舗情報が取得できませんでした');
    }
  }
}
