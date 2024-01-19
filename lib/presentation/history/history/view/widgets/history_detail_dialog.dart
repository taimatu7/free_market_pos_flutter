import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryDetalDialog extends ConsumerStatefulWidget {
  const HistoryDetalDialog({Key? key}) : super(key: key);

  @override
  HistoryDetailDialogState createState() => HistoryDetailDialogState();
}

class HistoryDetailDialogState extends ConsumerState<HistoryDetalDialog> {
  final List<({String name, String quantity, String price})> list = [
    (name: "革ジャン", quantity: "1", price: "¥1,0000"),
    (name: "コート", quantity: "2", price: "¥2,0000")
  ];
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("詳細", textAlign: TextAlign.center),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.maxFinite,
        child: ListView.separated(
          shrinkWrap: false,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              title: Text(list[index].name),
              subtitle: Text(list[index].quantity),
              trailing: Text(list[index].price),
            );
          },
          separatorBuilder: (BuildContext context, int index) =>
              const Divider(height: 0),
          itemCount: list.length,
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("返品"),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("閉じる"),
        ),
      ],
    );
  }
}