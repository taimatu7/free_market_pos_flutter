import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryDetalDialog extends ConsumerStatefulWidget {
  const HistoryDetalDialog(this.returned, {Key? key}) : super(key: key);
  final bool returned;
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
        if (!widget.returned)
          TextButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      title: const Text("返品"),
                      content: const Text("返品しますか？"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                          child: const Text("いいえ"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context, true);
                          },
                          child: const Text("はい"),
                        ),
                      ],
                    );
                  }).then((value) {
                if (value == true) {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: const Text("返品完了"),
                          content: const Text("返品が完了しました。"),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: const Text("閉じる"),
                            ),
                          ],
                        );
                      }).then((value) => Navigator.pop(context));
                } else {
                  Navigator.pop(context);
                }
              });
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
