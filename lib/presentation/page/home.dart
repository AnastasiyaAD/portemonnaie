import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:portemonnaie/presentation/widget/bottomAppBarWithButton.dart';
import 'package:portemonnaie/presentation/widget/moneyCard.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static DateTime currentTime = DateTime.now();
  static String date = formatDate(currentTime, [dd,'/',mm,'/',yy]);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment:MainAxisAlignment.spaceBetween, 
            children: [
            const Text('Мы не Рокфеллеры пока!\nМы сэкономим и на соли ...',
                style: TextStyle(fontSize: 16.0, wordSpacing: 4)),
            Text(date)
          ])),
      body: ListView(
        children: <Widget>[MoneyCard()],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Добавить траты',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: const BottomAppBarWithButton(),
    );
  }
}
