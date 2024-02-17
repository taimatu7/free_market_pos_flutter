import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../usecase/history/queries/get_purchase_histories.dart';
import '../../usecase/payment/commands/save_purchase_history.dart';
import '../../usecase/registration/commands/delete_category.dart';
import '../../usecase/registration/commands/delete_product.dart';
import '../../usecase/registration/commands/register_category.dart';
import '../../usecase/registration/commands/register_product.dart';
import '../../usecase/registration/commands/register_store.dart';
import '../../usecase/registration/commands/update_category.dart';
import '../../usecase/registration/commands/update_product.dart';
import '../../usecase/registration/queries/get_all_categories.dart';
import '../../usecase/registration/queries/get_all_products.dart';
import '../../usecase/registration/queries/get_all_products_by_category.dart';
import '../../usecase/registration/queries/get_product.dart';
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
final updateCategoryUsecaseProvider = Provider<UpdateCategory>((ref) => UpdateCategory(ref.read(categoryRepositoryProvider)));
final deleteCategoryUsecaseProvider = Provider<DeleteCategory>((ref) => DeleteCategory(ref.read(categoryRepositoryProvider)));

final registerProductUsecaseProvider = Provider<RegisterProduct>((ref) => RegisterProduct(ref.read(productRepositoryProvider)));
final getAllProductsByCategoryUsecaseProvider =
    Provider<GetAllProductsByCategory>((ref) => GetAllProductsByCategory(ref.read(productRepositoryProvider)));
final getAllProductsUsecaseProvider = Provider<GetAllProducts>((ref) => GetAllProducts(ref.read(productRepositoryProvider)));
final getProductUsecaseProvider = Provider<GetProduct>((ref) => GetProduct(ref.read(productRepositoryProvider)));
final updateProductUsecaseProvider = Provider<UpdateProduct>((ref) => UpdateProduct(ref.read(productRepositoryProvider)));
final deleteProductUsecaseProvider = Provider<DeleteProduct>((ref) => DeleteProduct(ref.read(productRepositoryProvider)));

final savePurchaseHistoryUsecaseProvider = Provider<SavePurchaseHistory>((ref) => SavePurchaseHistory(ref.read(purchaseHistoryRepositoryProvider)));
final getPurchaseHistoryUsecaseProvider = Provider<GetPurchaseHistories>((ref) => GetPurchaseHistories(ref.read(purchaseHistoryRepositoryProvider)));
