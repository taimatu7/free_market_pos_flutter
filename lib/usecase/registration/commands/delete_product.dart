import '../../../domain/product/product.dart';
import '../../../domain/product/product_repository.dart';

class DeleteProduct {
  final ProductRepository _productRepository;

  DeleteProduct(this._productRepository);

  Future<void> execute(Product product) async {
    await _productRepository.delete(product);
  }
}
