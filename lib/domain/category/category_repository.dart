import 'category.dart';

abstract interface class CategoryRepository {
  Future<Category> create(Category category);
  Future<List<Category>> getAll();
  Future<Category> update(Category category);
  Future<Category> delete(Category category);
}
