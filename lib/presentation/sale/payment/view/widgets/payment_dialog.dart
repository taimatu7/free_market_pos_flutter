import 'package:flutter/material.dart';

class PaymentDialog extends StatelessWidget {
  const PaymentDialog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('受け取り金額を入力してください'),
      content: const TextField(
        keyboardType: TextInputType.number,
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('確定'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('キャンセル', style: TextStyle(color: Colors.red)),
            ),
          ],
        )
      ],
    );
  }
}
