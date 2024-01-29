import 'package:freezed_annotation/freezed_annotation.dart';

part '../../generated/domain/store/store.freezed.dart';

@freezed
class Store with _$Store {
  const factory Store({
    required String name,
  }) = _Store;
}
