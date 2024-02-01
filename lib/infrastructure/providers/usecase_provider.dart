import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../usecase/registration/commands/register_store.dart';
import '../../usecase/settings/queries/get_store.dart';
import 'repository_provider.dart';

final registerStoreUsecaseProvider = Provider<RegisterStore>((ref) => RegisterStore(ref.read(storeRepositoryProvider)));
final getStoreUsecaseProvider = Provider<GetStore>((ref) => GetStore(ref.read(storeRepositoryProvider)));
