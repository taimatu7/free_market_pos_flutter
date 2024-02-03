import '../category/category.dart';
import 'product.dart';

abstract interface class ProductRepository {
  Future<Product> create(Product product);
  Future<List<Product>> getAllByCategory(Category category);
  Future<Product?> getById(String id);
  Future<Product> update(Product product);
  Future<Product> delete(Product product);
}
