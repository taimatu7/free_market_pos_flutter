import '../../../domain/product/product.dart';
import '../../../domain/product/product_repository.dart';

class GetAllProducts {
  final ProductRepository _productRepository;

  GetAllProducts(this._productRepository);

  Future<List<Product>> execute() async {
    return await _productRepository.getAll();
  }
}
