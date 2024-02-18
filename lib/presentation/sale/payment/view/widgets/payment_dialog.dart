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

  String? validatePrice(String? value) {
    if (value == null || value.isEmpty) return '金額を入力してください';

    int? price = int.tryParse(value);

    if (price == null || price < salesAmount) {
      return '販売金額以上を入力してください';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return AlertDialog(
      title: Column(
        children: [
          const Text('受け取り金額を入力してください'),
          Text('販売金額: $salesAmount' '円'),
        ],
      ),
      content: Form(
        key: formKey,
        child: TextFormField(
          controller: _controller,
          keyboardType: TextInputType.number,
          validator: validatePrice,
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () async {
                if (!(formKey.currentState?.validate() ?? false)) return;

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
