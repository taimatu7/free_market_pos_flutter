import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/components/cart/cart.dart';
import 'package:free_market_pos_flutter/presentation/components/side_drawer/side_drawer.dart';
import 'package:free_market_pos_flutter/presentation/constants/constants.dart';
import 'package:free_market_pos_flutter/presentation/sale/payment/view/payment_screen.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({Key? key}) : super(key: key);
  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  // 初期はすべてのカテゴリーを選択
  int _selectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品販売', style: TextStyle(color: titleColor)),
        backgroundColor: appBarColor,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
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
            child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    child: Card(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text(
                                itemList[index].name,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                    fontSize: itemTitleFontSizeSale),
                              ),
                            ),
                          ),
                          const Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.all(10.0),
                              child: Text(
                                '¥10,000',
                                textAlign: TextAlign.right,
                                style:
                                    TextStyle(fontSize: itemPriceFontSizeSale),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return const PaymentScreen();
                      }));
                    },
                  );
                },
                itemCount: itemList.length),
          ),
        ],
      ),
    );
  }

  // テストデータ
  // カテゴリーリスト
  final categoryList = ["すべて", "古着", "おもちゃ", "骨董品", "食器"];

  // 商品リスト
  final List<({String name, int price})> itemList = [
    (name: "革ジャン", price: 10000),
    (name: "コート", price: 12000),
    (name: "ジャージ上下", price: 3000),
    (name: "スニーカー", price: 5000),
    (name: "ハイヒール", price: 3000),
    (name: "ワンピース", price: 5000),
  ];
}
