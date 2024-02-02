import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../domain/store/store.dart';

part '../../../../generated/presentation/settings/settings/view_model/settings_screen_model.freezed.dart';

@freezed
class SettingsScreenModel with _$SettingsScreenModel {
  factory SettingsScreenModel({Store? store, String? version}) = _SettingsScreenModel;
}
