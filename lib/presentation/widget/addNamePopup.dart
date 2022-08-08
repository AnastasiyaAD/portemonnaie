import 'package:flutter/material.dart';

class AddNamePopup extends StatefulWidget {
  const AddNamePopup({Key? key}) : super(key: key);
  @override
  State createState() => _AddNamePopupState();
}

class _AddNamePopupState extends State<AddNamePopup> {

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
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 20,
          ),
          hintText: 'Название',
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
