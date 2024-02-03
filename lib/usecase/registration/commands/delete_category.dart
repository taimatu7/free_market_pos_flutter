import '../../../domain/category/category.dart';
import '../../../domain/category/category_repository.dart';

class DeleteCategory {
  final CategoryRepository _categoryRepository;

  DeleteCategory(this._categoryRepository);

  Future<void> execute(Category category) async {
    await _categoryRepository.delete(category);
  }
}
