import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../common/extensions/datetime_extension.dart';
import '../../../../../domain/purchase_history/purchase_history.dart';

class HistoryDetalDialog extends ConsumerStatefulWidget {
  final List<PurchaseHistory> purchaseHistories;
  const HistoryDetalDialog({Key? key, required this.purchaseHistories}) : super(key: key);

  @override
  HistoryDetailDialogState createState() => HistoryDetailDialogState();
}

class HistoryDetailDialogState extends ConsumerState<HistoryDetalDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('詳細', textAlign: TextAlign.center),
      content: SizedBox(
        height: MediaQuery.of(context).size.height * 0.4,
        width: double.maxFinite,
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('購入日'),
                Text(widget.purchaseHistories.first.createdAt.toYyyyMmDdHhMmSs()),
              ]),
            ),
            Expanded(
                flex: 1,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('合計金額'),
                    Text('${widget.purchaseHistories.first.salesAmount}円'),
                  ],
                )),
            Expanded(
              flex: 1,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('支払い金額'),
                Text('${widget.purchaseHistories.first.paymentAmount}円'),
              ]),
            ),
            Expanded(
              flex: 1,
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                const Text('お釣り'),
                Text('${widget.purchaseHistories.first.paymentAmount - widget.purchaseHistories.first.salesAmount}円'),
              ]),
            ),
            Expanded(
              flex: 8,
              child: ListView.separated(
                shrinkWrap: false,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      title: Text('${widget.purchaseHistories[index].details?.productName}'),
                      subtitle: Text('個数:${widget.purchaseHistories[index].details?.quantity}'),
                      trailing: Text('${widget.purchaseHistories[index].details?.price}円'));
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(height: 0),
                itemCount: widget.purchaseHistories.length,
              ),
            ),
          ],
        ),
      ),
      actions: [
        // TODO 次回以降の返品機能実装時にコメントアウトを外す

        // if (!widget.returned)
        //   TextButton(
        //     onPressed: () {
        //       showDialog(
        //           context: context,
        //           builder: (_) {
        //             return AlertDialog(
        //               title: const Text('返品'),
        //               content: const Text('返品しますか？'),
        //               actions: [
        //                 TextButton(
        //                   onPressed: () {
        //                     Navigator.pop(context, false);
        //                   },
        //                   child: const Text('いいえ'),
        //                 ),
        //                 TextButton(
        //                   onPressed: () {
        //                     Navigator.pop(context, true);
        //                   },
        //                   child: const Text('はい'),
        //                 ),
        //               ],
        //             );
        //           }).then((value) {
        //         if (value == true) {
        //           showDialog(
        //               context: context,
        //               builder: (_) {
        //                 return AlertDialog(
        //                   title: const Text('返品完了'),
        //                   content: const Text('返品が完了しました。'),
        //                   actions: [
        //                     TextButton(
        //                       onPressed: () {
        //                         Navigator.pop(context);
        //                       },
        //                       child: const Text('閉じる'),
        //                     ),
        //                   ],
        //                 );
        //               }).then((value) => Navigator.pop(context));
        //         } else {
        //           Navigator.pop(context);
        //         }
        //       });
        //     },
        //     child: const Text('返品'),
        //   ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('閉じる'),
        ),
      ],
    );
  }
}
