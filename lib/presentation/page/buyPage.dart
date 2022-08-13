import 'package:flutter/material.dart';
import 'package:portemonnaie/presentation/page/home.dart';
import 'package:portemonnaie/presentation/widget/buyForm.dart';

class BuyPage extends StatefulWidget {
  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> with TickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment:MainAxisAlignment.start, 
            children: [
            IconButton(
              tooltip: 'back',
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            const Padding(
              padding: EdgeInsets.all(16.0), 
              child: Text('Казна пустеет, Милорд!',style: TextStyle(fontSize: 14.0, wordSpacing: 4))),
          ]),
        ),
      body: const Center(child: BuyForm())
      
    );
  }
}