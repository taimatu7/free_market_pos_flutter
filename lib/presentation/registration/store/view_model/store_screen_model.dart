import 'package:freezed_annotation/freezed_annotation.dart';

part '../../../../generated/presentation/registration/store/view_model/store_screen_model.freezed.dart';

@freezed
class StoreScreenModel with _$StoreScreenModel {
  factory StoreScreenModel({@Default(false) bool registered, @Default(true) bool isFirstRegistered}) = _StoreScreenModel;
}
