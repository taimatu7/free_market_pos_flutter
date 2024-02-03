import '../../../domain/category/category.dart';
import '../../../domain/category/category_repository.dart';

class UpdateCategory {
  final CategoryRepository _categoryRepository;

  UpdateCategory(this._categoryRepository);

  Future<void> execute(Category category) async {
    await _categoryRepository.update(category);
  }
}
