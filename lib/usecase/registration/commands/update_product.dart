import '../../../domain/product/product.dart';
import '../../../domain/product/product_repository.dart';

class UpdateProduct {
  final ProductRepository _productRepository;

  UpdateProduct(this._productRepository);

  Future<void> execute(Product product) async {
    await _productRepository.update(product);
  }
}
