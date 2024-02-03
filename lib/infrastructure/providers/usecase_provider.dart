import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../usecase/registration/commands/delete_category.dart';
import '../../usecase/registration/commands/register_category.dart';
import '../../usecase/registration/commands/register_store.dart';
import '../../usecase/registration/commands/update_category.dart';
import '../../usecase/registration/queries/get_all_categories.dart';
import '../../usecase/settings/commands/update_store.dart';
import '../../usecase/settings/queries/get_store.dart';
import '../../usecase/settings/queries/get_version.dart';
import 'repository_provider.dart';

final registerStoreUsecaseProvider = Provider<RegisterStore>((ref) => RegisterStore(ref.read(storeRepositoryProvider)));
final getStoreUsecaseProvider = Provider<GetStore>((ref) => GetStore(ref.read(storeRepositoryProvider)));
final updateStoreUsecaseProvider = Provider<UpdateStore>((ref) => UpdateStore(ref.read(storeRepositoryProvider)));

final getVersionUsecaseProvider = Provider<GetVersion>((ref) => GetVersion());

final registerCategoryUsecaseProvider = Provider<RegisterCategory>((ref) => RegisterCategory(ref.read(categoryRepositoryProvider)));
final getCategoryUsecaseProvider = Provider<GetAllCategories>((ref) => GetAllCategories(ref.read(categoryRepositoryProvider)));
final updateUpdateUsecaseProvider = Provider<UpdateCategory>((ref) => UpdateCategory(ref.read(categoryRepositoryProvider)));
final deleteCategoryUsecaseProvider = Provider<DeleteCategory>((ref) => DeleteCategory(ref.read(categoryRepositoryProvider)));
