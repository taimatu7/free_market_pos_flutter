import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../usecase/registration/commands/register_store.dart';
import '../../usecase/settings/commands/update_store.dart';
import '../../usecase/settings/queries/get_store.dart';
import '../../usecase/settings/queries/get_version.dart';
import 'repository_provider.dart';

final registerStoreUsecaseProvider = Provider<RegisterStore>((ref) => RegisterStore(ref.read(storeRepositoryProvider)));
final getStoreUsecaseProvider = Provider<GetStore>((ref) => GetStore(ref.read(storeRepositoryProvider)));
final updateStoreUsecaseProvider = Provider<UpdateStore>((ref) => UpdateStore(ref.read(storeRepositoryProvider)));

final getVersionUsecaseProvider = Provider<GetVersion>((ref) => GetVersion());
