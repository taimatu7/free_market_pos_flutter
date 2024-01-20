import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/components/side_drawer/side_drawer.dart';
import 'package:free_market_pos_flutter/presentation/constants/constants.dart';
import 'package:free_market_pos_flutter/presentation/history/history/view/widgets/history_detail_dialog.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  final List<
      ({
        int id,
        String datetime,
        List<String> itemList,
        String quantity,
        String totalPrice,
        bool returned,
      })> list = [
    (
      id: 1,
      datetime: "2024/01/20 9:32",
      itemList: ["革ジャン", "コート"],
      quantity: "3",
      totalPrice: "¥3,0000",
      returned: false,
    ),
    (
      id: 2,
      datetime: "2024/01/20 10:30",
      itemList: ["スニーカー", "ワンピース", "ハイヒール"],
      quantity: "3",
      totalPrice: "¥2,0000",
      returned: true
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("会計", style: TextStyle(color: titleColor)),
          backgroundColor: appBarColor,
          centerTitle: true,
        ),
        drawer: const SideDrawer(),
        body: ListView.separated(
            itemBuilder: (_, int index) {
              return ListTile(
                  leading: Text(list[index].id.toString()),
                  title: Text(list[index].itemList.join(","),
                      overflow: TextOverflow.ellipsis),
                  subtitle: Row(
                    children: [
                      Text(list[index].datetime),
                      const SizedBox(width: 10),
                      Text("個数:${list[index].quantity}"),
                      if (list[index].returned)
                        const Padding(
                          padding: EdgeInsets.only(left: 10),
                          child:
                              Text("返品済", style: TextStyle(color: Colors.red)),
                        ),
                    ],
                  ),
                  trailing: Text(list[index].totalPrice),
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) {
                          return HistoryDetalDialog(list[index].returned);
                        });
                  });
            },
            separatorBuilder: (_, int index) => const Divider(height: 0),
            itemCount: list.length));
  }
}
