import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common/extensions/datetime_extension.dart';
import '../../../../domain/purchase_history/purchase_history.dart';
import '../../../components/side_drawer/view/side_drawer.dart';
import '../../../constants/constants.dart';
import '../view_model/history_screen_view_model.dart';
import 'widgets/history_detail_dialog.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  final List<(String, List<PurchaseHistory>)> _purchaseHistories = [];

  late Future<void> _initFunction;

  @override
  void initState() {
    super.initState();
    _initFunction = _init();
  }

  Future<void> _init() async {
    await ref.read(historyViewModelProvider.notifier).getHistories();

    final model = ref.read(historyViewModelProvider);

    _purchaseHistories.clear();
    model.purchaseProducts.map((e) {
      if (_purchaseHistories.isEmpty) {
        _purchaseHistories.add((e.id, [e]));
      } else {
        bool isExist = false;
        for (int i = 0; i < _purchaseHistories.length; i++) {
          if (_purchaseHistories[i].$1 == e.id) {
            _purchaseHistories[i].$2.add(e);
            isExist = true;
            break;
          }
        }
        if (!isExist) _purchaseHistories.add((e.id, [e]));
      }
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('販売履歴', style: TextStyle(color: titleColor)),
          backgroundColor: appBarColor,
          centerTitle: true,
        ),
        drawer: const SideDrawer(),
        body: FutureBuilder(
          future: _initFunction,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) const Center(child: CircularProgressIndicator());
            return ListView.separated(
                itemBuilder: (_, int index) {
                  // TODO メソッドで切り出す
                  int count = 0;
                  _purchaseHistories[index].$2.map((element) => count += element.details?.quantity ?? 0).toList();

                  // TODO メソッドで切り出す
                  int totalPrice = 0;
                  _purchaseHistories[index]
                      .$2
                      .map((element) => totalPrice += (element.details?.price ?? 0) * (element.details?.quantity ?? 0))
                      .toList();

                  return ListTile(
                      leading: Text((index + 1).toString()),
                      title: Text(_purchaseHistories[index].$2.map((e) => e.details?.productName).join(', '), overflow: TextOverflow.ellipsis),
                      subtitle: Row(
                        children: [
                          Text(_purchaseHistories[index].$2[0].createdAt.toYyyyMmDdHhMmSs()),
                          const SizedBox(width: 10),
                          Text('個数:${count.toString()}'),
                          // TODO 返品は別バージョンで実装予定
                          // if (_purchaseProducts[index].returned)
                          //   const Padding(
                          //     padding: EdgeInsets.only(left: 10),
                          //     child: Text('返品済', style: TextStyle(color: Colors.red)),
                          //   ),
                        ],
                      ),
                      trailing: Text(totalPrice.toString()),
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return HistoryDetalDialog(purchaseHistories: _purchaseHistories[index].$2);
                            });
                      });
                },
                separatorBuilder: (_, int index) => const Divider(height: 0),
                itemCount: _purchaseHistories.length);
          },
        ));
  }
}
