import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/category/category_repository.dart';
import '../../domain/product/product_repository.dart';
import '../../domain/store/store_repository.dart';

final storeRepositoryProvider = Provider<StoreRepository>((_) => throw UnimplementedError());
final categoryRepositoryProvider = Provider<CategoryRepository>((_) => throw UnimplementedError());
final productRepositoryProvider = Provider<ProductRepository>((_) => throw UnimplementedError());
