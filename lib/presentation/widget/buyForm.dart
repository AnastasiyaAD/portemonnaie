import 'package:flutter/material.dart';

class BuyForm extends StatefulWidget {
  const BuyForm({super.key});

  @override
  BuyFormState createState() {
    return BuyFormState();
  }
}
class BuyFormState extends State<BuyForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          
        ],
      ),
    );
  }
}
