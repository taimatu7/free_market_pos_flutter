import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/category/category.dart';
import '../../../../domain/product/product.dart';
import '../../../components/cart/view/cart.dart';
import '../../../components/cart/view_model/cart_view_model.dart';
import '../../../components/side_drawer/view/side_drawer.dart';
import '../../../constants/constants.dart';
import '../view_model/sale_screen_view_model.dart';
import 'widgets/completed_payment_dialog.dart';

class SaleScreen extends ConsumerStatefulWidget {
  const SaleScreen({Key? key, required this.paied}) : super(key: key);
  final bool paied;
  @override
  ConsumerState<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends ConsumerState<SaleScreen> {
  int _selectedCategoryIndex = 0;
  final List<Category> _categories = [];
  final List<Product> _products = [];
  late Future<void> _initFunction;

  @override
  void initState() {
    super.initState();
    _initFunction = _init();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (widget.paied) {
        await showDialog(
            context: context,
            builder: (BuildContext context) {
              return const CompletedPaymentDialog();
            });
      }
    });
  }

  Future<void> _init() async {
    final notifier = ref.read(saleScreenViewModelProvider.notifier);
    await notifier.getAllCategory();
    await notifier.getAllProducts();

    final model = ref.read(saleScreenViewModelProvider);
    _categories.clear();
    _categories.addAll(model.categories);
    _products.clear();
    _products.addAll(model.products);
  }

  @override
  Widget build(BuildContext context) {
    final cartNotifier = ref.read(cartViewModelProvider.notifier);
    final cartModel = ref.read(cartViewModelProvider);

    return FutureBuilder(
        future: _initFunction,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) const Center(child: CircularProgressIndicator());
          // TODO カテゴリーごと商品を取得する
          final filteredProductBySelectedCategory =
              _products.where((element) => element.categoryId == _categories[_selectedCategoryIndex].id).toList();
          return Scaffold(
            appBar: AppBar(
              title: const Text('商品販売', style: TextStyle(color: titleColor)),
              backgroundColor: appBarColor,
              centerTitle: true,
              actions: const [
                Padding(
                  padding: EdgeInsets.only(right: 15.0),
                  child: Cart(),
                )
              ],
            ),
            drawer: const SideDrawer(),
            body: Row(
              children: [
                Expanded(
                    flex: 1,
                    child: ListView.separated(
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                              color: index == _selectedCategoryIndex ? Colors.lightBlueAccent : null,
                              child: ListTile(
                                title: Text(_categories[index].name),
                                onTap: () {
                                  setState(() {
                                    // タップされたら選択されたカテゴリーのインデックスを更新
                                    _selectedCategoryIndex = index;
                                  });
                                },
                              ));
                        },
                        separatorBuilder: (BuildContext context, int index) => const Divider(height: 0),
                        itemCount: _categories.length)),
                Container(
                  width: 2,
                  color: dividerColor,
                ),
                Expanded(
                  flex: 3,
                  child: ListView.builder(
                      itemBuilder: (BuildContext context, int index) {
                        final isProductInCart = cartModel.products.contains(filteredProductBySelectedCategory[index]);
                        return GestureDetector(
                          child: Card(
                            color: isProductInCart ? Colors.blue[200] : Colors.blue[50],
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(5)),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: GestureDetector(
                                    behavior: HitTestBehavior.opaque,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            filteredProductBySelectedCategory[index].name,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(fontSize: itemTitleFontSizeSale),
                                          ),
                                          Text(
                                            '${filteredProductBySelectedCategory[index].price}円',
                                            textAlign: TextAlign.right,
                                            style: const TextStyle(fontSize: itemPriceFontSizeSale),
                                          ),
                                        ],
                                      ),
                                    ),
                                    onTap: () {
                                      setState(() {
                                        cartNotifier.addProduct(filteredProductBySelectedCategory[index]);
                                      });
                                    },
                                  ),
                                ),
                                Expanded(
                                    flex: 1,
                                    child: Text(
                                      isProductInCart
                                          ? '×${cartModel.products.where((p) => p.id == filteredProductBySelectedCategory[index].id).length}'
                                          : '',
                                      style: const TextStyle(color: Colors.white),
                                    )),
                                Expanded(
                                    flex: 2,
                                    child: GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      child: Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child:
                                              isProductInCart ? GestureDetector(child: const Icon(Icons.clear, color: Colors.white)) : Container()),
                                      onTap: () => setState(() {
                                        if (isProductInCart) {
                                          cartNotifier.removeProduct(filteredProductBySelectedCategory[index]);
                                        }
                                      }),
                                    ))
                              ],
                            ),
                          ),
                          onTap: () {
                            // TODO タップされたら商品をカートに追加
                          },
                        );
                      },
                      itemCount: filteredProductBySelectedCategory.length),
                ),
              ],
            ),
          );
        });
  }
}
