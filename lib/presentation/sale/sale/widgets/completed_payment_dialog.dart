import 'package:flutter/material.dart';

class CompletedPaymentDialog extends StatelessWidget {
  const CompletedPaymentDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('お支払いが完了しました'),
      content: const Text('お買い上げありがとうございます'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
