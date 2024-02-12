import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../domain/product/product.dart';
import '../../../components/cart/view_model/cart_view_model.dart';
import '../../../constants/constants.dart';
import '../../sale/view/sale_screen.dart';
import 'widgets/payment_dialog.dart';

class PaymentScreen extends ConsumerStatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);
  @override
  ConsumerState<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends ConsumerState<PaymentScreen> {
  final List<(Product, int)> paymentDetails = [];

  @override
  void initState() {
    super.initState();
    final cartModel = ref.read(cartViewModelProvider);
    paymentDetails.addAll(getPaymentDetails(cartModel.products));
  }

  // TODO paymentDetailsのドメインクラス化
  List<(Product product, int quantity)> getPaymentDetails(List<Product> products) {
    // TODO リファクタリング
    final List<(Product product, int quantity)> paymentDetails = [];
    for (Product product in products) {
      if (paymentDetails.isEmpty) {
        paymentDetails.add((product, 1));
        continue;
      }
      bool isExist = false;
      for (int i = 0; i < paymentDetails.length; i++) {
        if (product == paymentDetails[i].$1) {
          paymentDetails[i] = (product, paymentDetails[i].$2 + 1);
          isExist = true;
          break;
        }
      }
      if (!isExist) {
        paymentDetails.add((product, 1));
      }
      continue;
    }
    return paymentDetails;
  }

  int getPaymentTotal(List<(Product product, int quantity)> paymentDetails) {
    int total = 0;
    for (var element in paymentDetails) {
      total += element.$1.price * element.$2;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double targetHeight = screenHeight * 0.6;
    return Scaffold(
      appBar: AppBar(
        title: const Text('会計', style: TextStyle(color: titleColor)),
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
                      title: Text(paymentDetails[index].$1.name),
                      subtitle: Text('${paymentDetails[index].$2}個'),
                      trailing: Text('${paymentDetails[index].$1.price}円'),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => const Divider(height: 0),
                  itemCount: paymentDetails.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    const Expanded(
                        child: Text(
                      '合計金額',
                      textAlign: TextAlign.right,
                      style: TextStyle(fontSize: 20),
                    )),
                    Expanded(
                        child: Text(
                      '${getPaymentTotal(paymentDetails)}円',
                      textAlign: TextAlign.right,
                      style: const TextStyle(fontSize: 20),
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
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                            ),
                            onPressed: () {
                              showDialog(context: context, builder: (_) => const PaymentDialog()).then((value) {
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return const SaleScreen(
                                      paied: true,
                                    );
                                  },
                                ));
                              });
                            },
                            child: const Text('会計', style: TextStyle(fontSize: 20, color: Colors.white)))),
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
