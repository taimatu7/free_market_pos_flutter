import '../category/category.dart';
import 'product.dart';

abstract interface class ProductRepository {
  Future<Product> create(Product product);
  Future<List<Product>> getAllByCategory(Category category);
  Future<List<Product>> getAll();
  Future<Product?> getById(String id);
  Future<Product> update(Product product);
  Future<Product> delete(Product product);
}
