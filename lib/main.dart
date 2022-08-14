import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:portemonnaie/domain/model/buy/buy.dart';
import 'package:portemonnaie/domain/model/buy/typeBuy.dart';
import 'package:portemonnaie/domain/model/buy/shop.dart';
import 'package:portemonnaie/domain/model/currency.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'internal/application.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDir = await getApplicationDocumentsDirectory();
  final prefs = await SharedPreferences.getInstance();
  if(prefs.getDouble('totalSum')==null){
    await prefs.setDouble('totalSum', 0.0);
  }
  String appDocPath = appDocDir.path;
  Hive.init(appDocPath);
  Hive.registerAdapter(BuyAdapter());
  await Hive.openBox<Buy>('buy');
  Hive.registerAdapter(ShopAdapter());
  await Hive.openBox<Shop>('shop');
  Hive.registerAdapter(TypeBuyAdapter());
  await Hive.openBox<TypeBuy>('typeBuy');
  Hive.registerAdapter(CurrencyAdapter());
  await Hive.openBox<Currency>('currency');
  runApp(Application());
}
