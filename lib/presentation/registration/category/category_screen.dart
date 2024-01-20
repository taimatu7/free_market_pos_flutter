import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/constants/constants.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({Key? key}) : super(key: key);
  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final categoryList = ["すべて", "古着", "おもちゃ", "骨董品", "食器"];
  final forcusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('カテゴリー編集', style: TextStyle(color: titleColor)),
        backgroundColor: appBarColor,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text('カテゴリー追加'),
                      content: TextField(
                        focusNode: forcusNode,
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
                          onPressed: () {
                            forcusNode.unfocus();
                            showDialog(
                                context: context,
                                builder: (_) {
                                  return AlertDialog(
                                    title: const Text('カテゴリー追加'),
                                    content: const Text('カテゴリーを追加しました'),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  );
                                }).then((value) => Navigator.pop(context));
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
      body: ListView.separated(
          itemBuilder: (_, index) {
            return ListTile(
              title: Text(categoryList[index]),
              trailing: const Text("編集"),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) {
                      return AlertDialog(
                        title: const Text('カテゴリー編集'),
                        content: const TextField(
                          decoration: InputDecoration(
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
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: const Text('カテゴリー編集'),
                                      content: const Text('カテゴリーを編集しました'),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    );
                                  }).then((value) => Navigator.pop(context));
                            },
                            child: const Text('編集'),
                          ),
                        ],
                      );
                    });
              },
            );
          },
          separatorBuilder: (_, index) => const Divider(),
          itemCount: categoryList.length),
    );
  }
}
