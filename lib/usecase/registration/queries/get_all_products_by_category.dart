import '../../../domain/category/category.dart';
import '../../../domain/product/product.dart';
import '../../../domain/product/product_repository.dart';

class GetAllProductsByCategory {
  final ProductRepository _productRepository;

  GetAllProductsByCategory(this._productRepository);

  Future<List<Product>> execute(Category category) async {
    return await _productRepository.getAllByCategory(category);
  }
}
