import 'package:flutter/material.dart';
import 'package:free_market_pos_flutter/presentation/constants/constants.dart';
import 'package:free_market_pos_flutter/presentation/sale/payment/view/widgets/payment_dialog.dart';
import 'package:free_market_pos_flutter/presentation/sale/sale/view/sale_screen.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);
  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final List<({String name, String amount, String price})> list = [
    (name: "革ジャン", amount: "1", price: "¥1,0000"),
    (name: "コート", amount: "2", price: "¥2,0000")
  ];
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double targetHeight = screenHeight * 0.6;
    return Scaffold(
      appBar: AppBar(
        title: const Text("会計", style: TextStyle(color: titleColor)),
        backgroundColor: appBarColor,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: targetHeight,
                child: ListView.separated(
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(list[index].name),
                      subtitle: Text(list[index].amount),
                      trailing: Text(list[index].price),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(height: 0),
                  itemCount: 2,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                      "合計金額",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20),
                    )),
                    Expanded(
                        child: Text(
                      "¥3,0000",
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20),
                    )),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () {
                              showDialog(
                                      context: context,
                                      builder: (_) => const PaymentDialog())
                                  .then((value) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const SaleScreen(
                                      paymented: true,
                                    );
                                  },
                                ));
                              });
                            },
                            child: const Text("会計",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.white)))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
