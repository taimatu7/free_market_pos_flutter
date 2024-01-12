import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/sale/sale/view/sale_screen.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({Key? key}) : super(key: key);
  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Column(
          children: [
            const Text("StoreScreen"),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const SaleScreen();
                  }));
                },
                child: const Text("次の画面"))
          ],
        ),
      ),
    );
  }
}
