import '../../../domain/product/product.dart';
import '../../../domain/product/product_repository.dart';

class GetProduct {
  final ProductRepository _productRepository;

  GetProduct(this._productRepository);

  Future<Product?> execute(String categoryId) async {
    return await _productRepository.getById(categoryId);
  }
}
