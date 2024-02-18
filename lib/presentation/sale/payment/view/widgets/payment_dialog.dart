import 'package:flutter/material.dart';

import '../../../../../domain/product/product.dart';

class PaymentDialog extends StatelessWidget {
  final bool Function(List<(Product, int)>, int, int) onPressed;
  final List<(Product, int)> paymentDetails;
  final int salesAmount;

  PaymentDialog({
    Key? key,
    required this.onPressed,
    required this.paymentDetails,
    required this.salesAmount,
  }) : super(key: key);
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('受け取り金額を入力してください'),
      content: TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                final result = onPressed.call(paymentDetails, int.parse(_controller.text), salesAmount);
                if (context.mounted) {
                  Navigator.of(context).pop(result);
                }
              },
              child: const Text('確定'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('キャンセル', style: TextStyle(color: Colors.red)),
            ),
          ],
        )
      ],
    );
  }
}
