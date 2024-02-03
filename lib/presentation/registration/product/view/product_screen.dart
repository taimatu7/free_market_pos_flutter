import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/components/side_drawer/view/side_drawer.dart';
import 'package:free_market_pos_flutter/presentation/constants/constants.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({Key? key}) : super(key: key);
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _selectedCategoryIndex = 0;
  final categoryList = ["すべて", "古着", "おもちゃ", "骨董品", "食器"];
  List<DropdownMenuItem>? categoryDropDownList;
  final List<({String name, int price})> itemList = [
    (name: "革ジャン", price: 10000),
    (name: "コート", price: 12000),
    (name: "ジャージ上下", price: 3000),
    (name: "スニーカー", price: 5000),
    (name: "ハイヒール", price: 3000),
    (name: "ワンピース", price: 5000),
  ];
  final nameForcusNode = FocusNode();
  final priceForcusNode = FocusNode();

  String? selectedEditProcuctCategory;
  String? selectedAddProductCategory;

  @override
  void initState() {
    super.initState();
    categoryDropDownList = categoryList
        .map((e) => DropdownMenuItem(
              value: e,
              child: Text(e),
            ))
        .toList();
    selectedEditProcuctCategory = categoryDropDownList?.first.value.toString();
    selectedAddProductCategory = categoryDropDownList?.first.value.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品編集', style: TextStyle(color: titleColor)),
        backgroundColor: appBarColor,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return StatefulBuilder(builder: (context, setState) {
                      return AlertDialog(
                        title: const Text('商品追加'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              focusNode: nameForcusNode,
                              decoration: const InputDecoration(
                                labelText: '商品名',
                                hintText: '商品名を入力してください',
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: DropdownButton(
                                  value: selectedAddProductCategory,
                                  items: categoryDropDownList,
                                  onChanged: (value) {
                                    setState(() =>
                                        selectedAddProductCategory = value);
                                  }),
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('キャンセル'),
                          ),
                          TextButton(
                            onPressed: () {
                              nameForcusNode.unfocus();
                              showDialog(
                                  context: context,
                                  builder: (_) {
                                    return AlertDialog(
                                      title: const Text('商品追加'),
                                      content: const Text('商品を追加しました'),
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
                        color: index == _selectedCategoryIndex
                            ? Colors.lightBlueAccent
                            : null,
                        child: ListTile(
                          title: Text(categoryList[index]),
                          onTap: () {
                            setState(() {
                              // タップされたら選択されたカテゴリーのインデックスを更新
                              _selectedCategoryIndex = index;
                            });
                          },
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(height: 0),
                  itemCount: categoryList.length)),
          Container(
            width: 2,
            color: dividerColor,
          ),
          Expanded(
            flex: 3,
            child: ListView.separated(
                itemBuilder: (_, index) {
                  return ListTile(
                    title: Text(categoryList[index]),
                    trailing: const Text("編集"),
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (_) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: const Text('商品編集'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        focusNode: nameForcusNode,
                                        decoration: const InputDecoration(
                                          labelText: '商品名',
                                          hintText: '商品名を入力してください',
                                        ),
                                      ),
                                      TextField(
                                        keyboardType: TextInputType.number,
                                        focusNode: priceForcusNode,
                                        decoration: const InputDecoration(
                                          labelText: '商品名',
                                          hintText: '商品名を入力してください',
                                        ),
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: DropdownButton(
                                            value: selectedEditProcuctCategory,
                                            items: categoryDropDownList,
                                            onChanged: (value) {
                                              setState(() =>
                                                  selectedEditProcuctCategory =
                                                      value);
                                            }),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: const Text('キャンセル'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        nameForcusNode.unfocus();
                                        priceForcusNode.unfocus();
                                        showDialog(
                                                context: context,
                                                builder: (_) {
                                                  return AlertDialog(
                                                    title: const Text('商品編集'),
                                                    content:
                                                        const Text('商品を編集しました'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  );
                                                })
                                            .then((value) =>
                                                Navigator.pop(context));
                                      },
                                      child: const Text('編集'),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    },
                  );
                },
                separatorBuilder: (_, index) => const Divider(),
                itemCount: categoryList.length),
          ),
        ],
      ),
    );
  }
}
