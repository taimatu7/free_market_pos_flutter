import 'package:logger/logger.dart';
import 'package:realm/realm.dart';

import '../../../common/exceptions/base_exception.dart';
import '../../../domain/category/category.dart';
import '../../../domain/product/exceptions/create_product_exception.dart';
import '../../../domain/product/exceptions/delete_product_exception.dart';
import '../../../domain/product/exceptions/get_product_exception.dart';
import '../../../domain/product/exceptions/update_product_exception.dart';
import '../../../domain/product/product.dart';
import '../../../domain/product/product_repository.dart';
import '../../data/db/product.dart' as realm;

class ProductRepositoryImpl implements ProductRepository {
  final Realm _realm;

  ProductRepositoryImpl(this._realm);

  @override
  Future<Product> create(Product product) async {
    try {
      final createdProduct = product.toRealmModel();
      _realm.write(() {
        _realm.add(createdProduct);
      });
      return product;
    } catch (e, stackTrace) {
      Logger().e('商品作成エラー:$e', stackTrace: stackTrace);
      throw CreateProductException('');
    }
  }

  @override
  Future<List<Product>> getAllByCategory(Category category) async {
    try {
      final productModel = _realm.query<realm.Product>('category.id == ${category.id}');
      return productModel.map((e) => e.toDomainModel()).toList();
    } catch (e, stackTrace) {
      Logger().e('カテゴリーごとの商品取得エラー:$e', stackTrace: stackTrace);
      throw GetProductException('');
    }
  }

  @override
  Future<List<Product>> getAll() async {
    try {
      final productModel = _realm.all<realm.Product>();
      return productModel.map((e) => e.toDomainModel()).toList();
    } catch (e, stackTrace) {
      Logger().e('商品全取得エラー:$e', stackTrace: stackTrace);
      throw GetProductException('');
    }
  }

  @override
  Future<Product?> getById(String id) async {
    try {
      final productModel = _realm.find<realm.Product>(id);
      return productModel?.toDomainModel();
    } catch (e, stackTrace) {
      Logger().e('商品取得エラー:$e', stackTrace: stackTrace);
      throw GetProductException('');
    }
  }

  @override
  Future<Product> update(Product product) async {
    try {
      final productModel = _realm.find<realm.Product>(product.id);
      if (productModel == null) throw BaseException('');
      _realm.write(() {
        productModel.categoryId = product.categoryId;
        productModel.name = product.name;
      });
      return product;
    } catch (e, stackTrace) {
      Logger().e('商品更新エラー:$e', stackTrace: stackTrace);
      throw UpdateProductException('');
    }
  }

  @override
  Future<Product> delete(Product product) async {
    try {
      final productModel = _realm.find<realm.Product>(product.id);
      if (productModel == null) throw BaseException('');
      _realm.write(() {
        _realm.delete(productModel);
      });
      return product;
    } catch (e, stackTrace) {
      Logger().e('商品削除エラー:$e', stackTrace: stackTrace);
      throw DeleteProductException('');
    }
  }
}
