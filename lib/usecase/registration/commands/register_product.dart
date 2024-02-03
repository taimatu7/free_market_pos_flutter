import '../../../domain/product/product.dart';
import '../../../domain/product/product_repository.dart';

class RegisterProduct {
  final ProductRepository _productRepository;

  RegisterProduct(this._productRepository);

  Future<Product> execute(Product product) async {
    return await _productRepository.create(product);
  }
}
