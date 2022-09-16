import 'package:flutter/material.dart';

class AddIntPopup extends StatefulWidget {
  const AddIntPopup({Key? key}) : super(key: key);
  @override
  State createState() => _AddIntPopupState();
}

class _AddIntPopupState extends State<AddIntPopup> {

  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: TextFormField(
        controller: myController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          hintText: 'Сколько?',
          hintStyle: const TextStyle(fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context, myController.text);
          },
          child: const Text('Сохранить'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, '');
          },
          child: const Text('Отмена'),
        ),
      ],
    );
  }
}
