import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:portemonnaie/domain/model/buy/buy.dart';
import 'package:portemonnaie/domain/model/buy/shop.dart';
import 'package:portemonnaie/domain/model/currency.dart';
import 'package:portemonnaie/domain/model/buy/typeBuy.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingCard extends StatefulWidget {
  const SettingCard({Key? key}) : super(key: key);
  @override
  State createState() => _SettingCardState();
}

class _SettingCardState extends State<SettingCard> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  var shopBox = Hive.box<Shop>('shop');
  var typeBuyBox = Hive.box<TypeBuy>('typeBuy');
  var currencyBox = Hive.box<Currency>('currency');
  var buyBox = Hive.box<Buy>('buy');

  Future<void> cleanMemory() async {
    final SharedPreferences prefs = await _prefs;
    setState(() {
      prefs.setDouble('totalSum', 0.0);
      shopBox.deleteAll(shopBox.keys);
      typeBuyBox.deleteAll(typeBuyBox.keys);
      currencyBox.deleteAll(currencyBox.keys);
      buyBox.deleteAll(buyBox.keys);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        ElevatedButton(
          style: ButtonStyle(
            fixedSize: MaterialStateProperty.all(const Size(200, 40)),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text("Вы уверены, что хотите удалить все данные?"),
              action: SnackBarAction(
                label: "Да",
                onPressed: () {
                  cleanMemory();
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text(
                    "Данные удалены",
                  )));
                },
              ),
            ));
          },
          child: const Text("Удалить данные"),
        ),
      ],
    ));
  }
}
