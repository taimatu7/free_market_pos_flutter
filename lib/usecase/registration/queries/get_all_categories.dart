import '../../../domain/category/category.dart';
import '../../../domain/category/category_repository.dart';

class GetAllCategories {
  final CategoryRepository _categoryRepository;

  GetAllCategories(this._categoryRepository);

  Future<List<Category>> execute() async {
    return await _categoryRepository.getAll();
  }
}
