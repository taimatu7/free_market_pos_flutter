import 'package:flutter/material.dart';

class EditStoreNameDialog extends StatelessWidget {
  const EditStoreNameDialog({
    Key? key,
    required this.storeName,
    required this.onChanged,
    required this.onSave,
  }) : super(key: key);

  final String storeName;
  final ValueChanged<String> onChanged;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Store Name'),
      content: TextField(
        autofocus: true,
        decoration: const InputDecoration(
          labelText: 'Store Name',
          hintText: 'Enter store name',
        ),
        onChanged: onChanged,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: onSave,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
