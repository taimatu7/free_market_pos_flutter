import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/extensions/context_extension.dart';
import '../../../../domain/category/category.dart';
import '../../../components/side_drawer/view/side_drawer.dart';
import '../../../constants/constants.dart';
import '../view_model/category_screen_model.dart';
import '../view_model/category_screen_view_model.dart';

class CategoryScreen extends ConsumerStatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends ConsumerState<CategoryScreen> {
  final List<Category> categories = [];
  final forcusNode = FocusNode();
  late Future<void> _initFunction;

  @override
  void initState() {
    super.initState();
    _initFunction = _init();
  }

  Future<void> _init() async {
    final notifier = ref.read(categoryScreenViewModelProvider.notifier);
    await notifier.getAllCategory();
  }

  String? valideCategoryName(String? value) {
    if (value == null || value.isEmpty) return 'カテゴリー名を入力してください';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    ref.listen<CategoryScreenModel>(categoryScreenViewModelProvider, (previous, next) {
      setState(() {
        categories.clear();
        categories.addAll(next.categories);
      });
    });
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('カテゴリー編集', style: TextStyle(color: titleColor)),
          backgroundColor: appBarColor,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {
                final TextEditingController createCategoryNameController = TextEditingController();
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('カテゴリー追加'),
                        content: Form(
                          key: formKey,
                          child: TextFormField(
                            controller: createCategoryNameController,
                            focusNode: forcusNode,
                            decoration: const InputDecoration(
                              labelText: 'カテゴリー名',
                              hintText: 'カテゴリー名を入力してください',
                            ),
                            validator: valideCategoryName,
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('キャンセル'),
                          ),
                          TextButton(
                            onPressed: () async {
                              forcusNode.unfocus();
                              if (!(formKey.currentState?.validate() ?? false)) return;
                              final result =
                                  await ref.read(categoryScreenViewModelProvider.notifier).registerCategory(createCategoryNameController.text);
                              final text = result ? 'カテゴリーを追加しました' : 'カテゴリーの追加に失敗しました';
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
              },
              icon: const Icon(Icons.add),
              color: Colors.white,
            )
          ],
        ),
        drawer: const SideDrawer(),
        body: FutureBuilder(
            future: _initFunction,
            builder: (context, snapshot) {
              if (snapshot.connectionState != ConnectionState.done) const Center(child: CircularProgressIndicator());
              return ListView.separated(
                  itemBuilder: (_, index) {
                    return ListTile(
                      title: Text(categories[index].name),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          GestureDetector(
                            child: const Text('編集'),
                            onTap: () {
                              final updateCategoryNameController = TextEditingController(text: categories[index].name);
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: const Text('カテゴリー編集'),
                                      content: TextField(
                                        controller: updateCategoryNameController,
                                        decoration: const InputDecoration(
                                          labelText: 'カテゴリー名',
                                          hintText: 'カテゴリー名を入力してください',
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('キャンセル'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            final result = await ref
                                                .read(categoryScreenViewModelProvider.notifier)
                                                .updateCategory(categories[index], updateCategoryNameController.text);
                                            final text = result ? 'カテゴリーを編集しました' : 'カテゴリーの編集に失敗しました';
                                            if (context.mounted) {
                                              context.showSnackBar(text);
                                              Navigator.pop(context);
                                            }
                                          },
                                          child: const Text('編集'),
                                        ),
                                      ],
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
                                      title: const Text('カテゴリー削除'),
                                      content: const Text('カテゴリーを削除しますか？'),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: const Text('キャンセル'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            final result = await ref.read(categoryScreenViewModelProvider.notifier).deleteCategory(categories[index]);
                                            final text = result ? 'カテゴリーを削除しました' : 'カテゴリーの削除に失敗しました';
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
                      ),
                    );
                  },
                  separatorBuilder: (_, index) => const Divider(),
                  itemCount: categories.length);
            }),
      ),
    );
  }
}
