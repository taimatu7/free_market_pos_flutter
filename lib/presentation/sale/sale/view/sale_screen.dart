import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/components/side_drawer/side_drawer.dart';
import 'package:free_market_pos_flutter/presentation/sale/payment/view/payment_screen.dart';

class SaleScreen extends StatefulWidget {
  const SaleScreen({Key? key}) : super(key: key);
  @override
  State<SaleScreen> createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('商品販売'),
      ),
      drawer: const SideDrawer(),
      body: Column(
        children: [
          const Center(
            child: Text("SaleScreen"),
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const PaymentScreen();
                }));
              },
              child: const Text("次の画面"))
        ],
      ),
    );
  }
}
