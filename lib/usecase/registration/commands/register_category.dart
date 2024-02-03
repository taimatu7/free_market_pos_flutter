import '../../../domain/category/category.dart';
import '../../../domain/category/category_repository.dart';

class RegisterCategory {
  final CategoryRepository _categoryRepository;

  RegisterCategory(this._categoryRepository);

  Future<Category> execute(Category category) async {
    return await _categoryRepository.create(category);
  }
}
