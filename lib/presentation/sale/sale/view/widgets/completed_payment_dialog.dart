import 'package:flutter/material.dart';

class CompletedPaymentDialog extends StatelessWidget {
  const CompletedPaymentDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('決済完了'),
      content: const Text('決済が完了しました。'),
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
