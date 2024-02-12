import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/extensions/context_extension.dart';
import '../../../../domain/category/category.dart';
import '../../../../domain/product/product.dart';
import '../../../components/side_drawer/view/side_drawer.dart';
import '../../../constants/constants.dart';
import '../view_model/product_screen_model.dart';
import '../view_model/product_screen_view_model.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {
  int _selectedCategoryIndex = 0;
  final List<Category> _categories = [];
  final List<Product> _products = [];
  final List<DropdownMenuItem<Category>> _categoryDropDownList = [];

  Future<void> _init() async {
    final notifier = ref.read(productScreenViewModelProvider.notifier);
    await notifier.getAllCategory();
    await notifier.getAllProducts();

    final model = ref.read(productScreenViewModelProvider);
    _categories.clear();
    _categories.addAll(model.categories);
  }

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) return '金額を入力してください';

    int? price = int.tryParse(value);

    if (price == null || price < 0 || price > 999999) {
      return '0~999999で入力してください';
    }

    return null;
  }

  String? valideProductName(String? value) {
    if (value == null || value.isEmpty) return '商品名を入力してください';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ProductScreenModel>(productScreenViewModelProvider, (previous, next) {
      setState(() {
        _products.clear();
        _products.addAll(next.products);
      });
    });

    return FutureBuilder(
        future: _init(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) const Center(child: CircularProgressIndicator());
          _categoryDropDownList.clear();
          _categoryDropDownList.addAll(_categories
              .map((e) => DropdownMenuItem<Category>(
                    value: e,
                    child: Text(e.name),
                  ))
              .toList());

          // TODO カテゴリーごと商品を取得する
          final filteredProductBySelectedCategory =
              _products.where((element) => element.categoryId == _categories[_selectedCategoryIndex].id).toList();

          return Scaffold(
            appBar: AppBar(
              title: const Text('商品編集', style: TextStyle(color: titleColor)),
              backgroundColor: appBarColor,
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Category? selectedAddProductCategory;
                    final TextEditingController nameController = TextEditingController();
                    final TextEditingController priceController = TextEditingController();
                    final formKey = GlobalKey<FormState>();
                    // TODO 商品追加・編集のダイアログを共通化する
                    showDialog(
                        context: context,
                        builder: (_) {
                          return StatefulBuilder(builder: (context, setState) {
                            return AlertDialog(
                              title: const Text('商品追加'),
                              content: Form(
                                key: formKey,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: nameController,
                                      decoration: const InputDecoration(
                                        labelText: '商品名',
                                        hintText: '商品名を入力してください',
                                      ),
                                      validator: valideProductName,
                                    ),
                                    TextFormField(
                                        controller: priceController,
                                        keyboardType: TextInputType.number,
                                        decoration: const InputDecoration(
                                          labelText: '金額',
                                          hintText: '商品名を入力してください',
                                        ),
                                        validator: validatePrice),
                                    Container(
                                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                                      child: _categoryDropDownList.isNotEmpty
                                          ? SizedBox(
                                              width: double.infinity,
                                              child: DropdownButton<Category>(
                                                  value: selectedAddProductCategory,
                                                  items: _categoryDropDownList,
                                                  onChanged: (value) {
                                                    setState(() => selectedAddProductCategory = value);
                                                  }),
                                            )
                                          : const Text('カテゴリーを追加してください。', style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('キャンセル'),
                                ),
                                // TODO 追加できない場合はボタンを押せないようにする、ボタンのカスタムウィジェット化
                                TextButton(
                                  onPressed: () async {
                                    FocusScope.of(context).unfocus();
                                    if (!(formKey.currentState?.validate() ?? false)) return;

                                    final local = selectedAddProductCategory;
                                    if (local == null) return;

                                    final result = await ref
                                        .read(productScreenViewModelProvider.notifier)
                                        .registerProduct(local, nameController.text, priceController.text);
                                    final text = result ? '商品を追加しました' : '商品の追加に失敗しました';
                                    if (context.mounted) {
                                      context.showSnackBar(text);
                                      Navigator.pop(context);
                                    }
                                  },
                                  child: const Text('追加'),
                                ),
                              ],
                            );
                          });
                        });
                  },
                  icon: const Icon(Icons.add),
                  color: Colors.white,
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
                  child: ListView.separated(
                      itemBuilder: (_, index) {
                        return ListTile(
                            title: Text(filteredProductBySelectedCategory[index].name),
                            subtitle: Text('${filteredProductBySelectedCategory[index].price}円'),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  child: const Text('編集'),
                                  onTap: () {
                                    Category? selectedEditProductCategory;
                                    final TextEditingController nameController = TextEditingController();
                                    final TextEditingController priceController = TextEditingController();
                                    final formKey = GlobalKey<FormState>();

                                    nameController.text = filteredProductBySelectedCategory[index].name;
                                    priceController.text = filteredProductBySelectedCategory[index].price.toString();
                                    selectedEditProductCategory =
                                        _categories.firstWhere((element) => element.id == filteredProductBySelectedCategory[index].categoryId);

                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return AlertDialog(
                                                title: const Text('商品編集'),
                                                content: Form(
                                                  key: formKey,
                                                  child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      TextFormField(
                                                        controller: nameController,
                                                        decoration: const InputDecoration(
                                                          labelText: '商品名',
                                                          hintText: '商品名を入力してください',
                                                        ),
                                                        validator: valideProductName,
                                                      ),
                                                      TextFormField(
                                                          controller: priceController,
                                                          keyboardType: TextInputType.number,
                                                          decoration: const InputDecoration(
                                                            labelText: '金額',
                                                            hintText: '商品名を入力してください',
                                                          ),
                                                          validator: validatePrice),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: DropdownButton(
                                                            value: selectedEditProductCategory,
                                                            items: _categoryDropDownList,
                                                            onChanged: (value) {
                                                              setState(() => selectedEditProductCategory = value);
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context),
                                                    child: const Text('キャンセル'),
                                                  ),
                                                  TextButton(
                                                    onPressed: () async {
                                                      FocusScope.of(context).unfocus();
                                                      if (!(formKey.currentState?.validate() ?? false)) return;

                                                      final local = selectedEditProductCategory;
                                                      if (local == null) return;

                                                      final result = await ref.read(productScreenViewModelProvider.notifier).updateProduct(
                                                          filteredProductBySelectedCategory[index],
                                                          nameController.text,
                                                          priceController.text,
                                                          local.id);

                                                      final text = result ? '商品を編集しました' : '商品の編集に失敗しました';
                                                      if (context.mounted) {
                                                        context.showSnackBar(text);
                                                        Navigator.pop(context);
                                                      }
                                                    },
                                                    child: const Text('編集'),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        });
                                  },
                                ),
                                const SizedBox(
                                  width: 40,
                                ),
                                GestureDetector(
                                  child: const Text('削除'),
                                  onTap: () {
                                    showDialog(
                                        context: context,
                                        builder: (_) {
                                          return AlertDialog(
                                            title: const Text('商品削除'),
                                            content: const Text('商品を削除しますか？'),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(context),
                                                child: const Text('キャンセル'),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  final result = await ref
                                                      .read(productScreenViewModelProvider.notifier)
                                                      .deleteProduct(filteredProductBySelectedCategory[index]);
                                                  final text = result ? '商品を削除しました' : '商品の削除に失敗しました';
                                                  if (context.mounted) {
                                                    context.showSnackBar(text);
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: const Text('削除'),
                                              ),
                                            ],
                                          );
                                        });
                                  },
                                ),
                              ],
                            ));
                      },
                      separatorBuilder: (_, index) => const Divider(),
                      itemCount: filteredProductBySelectedCategory.length),
                ),
              ],
            ),
          );
        });
  }
}
